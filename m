Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDBA4200B3
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Oct 2021 10:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJCIQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Oct 2021 04:16:27 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:55126 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJCIQ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Oct 2021 04:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633248880; x=1664784880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bcbu4ixV5rW8UtC2qPoTa61LLAKNCrxt8Dj76a0MjSs=;
  b=K8pnMQnkDEqLsfhL2nVQCNeBi5W0A0Xj1ERq5OHknNU8FrzaHM2+RCvx
   pW8ZEz/mRPhn5E8NI+4GVEH7404UouNQkIkAb24H/+taGOEo8RJigDHfj
   yp5psWe1pSmK2IgcjG5BTPCsjKfKm5ZeNSyUZeps2XTiD5dVlM/ZNIfwa
   8=;
X-IronPort-AV: E=Sophos;i="5.85,343,1624320000"; 
   d="scan'208";a="962110459"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-28a78e3f.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 03 Oct 2021 08:14:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-28a78e3f.us-west-2.amazon.com (Postfix) with ESMTPS id 60657A0D72;
        Sun,  3 Oct 2021 08:14:31 +0000 (UTC)
Received: from [192.168.31.73] (10.43.161.107) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sun, 3 Oct
 2021 08:14:26 +0000
Message-ID: <ca6e779b-9e5e-b24f-361b-f2ca08725761@amazon.com>
Date:   Sun, 3 Oct 2021 11:14:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH for-next v3] RDMA/efa: CQ notifications
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210930121602.63131-1-galpress@amazon.com>
 <YVZIzdu6c/zuZUZK@unreal>
From:   Gal Pressman <galpress@amazon.com>
In-Reply-To: <YVZIzdu6c/zuZUZK@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.107]
X-ClientProxiedBy: EX13D49UWC004.ant.amazon.com (10.43.162.106) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01/10/2021 2:31, Leon Romanovsky wrote:
> On Thu, Sep 30, 2021 at 03:16:00PM +0300, Gal Pressman wrote:
>> This patch adds support for CQ notifications through the standard verbs
>> api.
>>
>> In order to achieve that, a new event queue (EQ) object is introduced,
>> which is in charge of reporting completion events to the driver.
>> On driver load, EQs are allocated and their affinity is set to a single
>> cpu. When a user app creates a CQ with a completion channel, the
>> completion vector number is converted to a EQ number, which is in charge
>> of reporting the CQ events.
>>
>> In addition, the CQ creation admin command now returns an offset for the
>> CQ doorbell, which is mapped to the userspace provider and is used to
>> arm the CQ when requested by the user.
>>
>> The EQs use a single doorbell (located on the registers BAR), which
>> encodes the EQ number and arm as part of the doorbell value.
>> The EQs are polled by the driver on each new EQE, and arm it when the
>> poll is completed.
>>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>> PR was sent:
>> https://github.com/linux-rdma/rdma-core/pull/1044
>>
>> Changelog -
>> v2->v3: https://lore.kernel.org/linux-rdma/20210913120406.61745-1-galpress@amazon.com/
>> * Only store CQs with interrupts enabled in the CQs xarray
>> * Add a comment before the xa_load to explain why it is safe
>>
>> v1->v2: https://lore.kernel.org/linux-rdma/20210811151131.39138-1-galpress@amazon.com/
>> * Replace xa_init_flags() with xa_init()
>> * Add a synchronize_irq() in destroy_cq flow to prevent a race with
>>   interrupt flow.
>> ---
>>  drivers/infiniband/hw/efa/efa.h               |  19 +-
>>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 100 +++++++++-
>>  drivers/infiniband/hw/efa/efa_admin_defs.h    |  41 ++++
>>  drivers/infiniband/hw/efa/efa_com.c           | 171 ++++++++++++++++
>>  drivers/infiniband/hw/efa/efa_com.h           |  38 +++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  35 +++-
>>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  10 +-
>>  drivers/infiniband/hw/efa/efa_main.c          | 185 +++++++++++++++---
>>  drivers/infiniband/hw/efa/efa_regs_defs.h     |   7 +-
>>  drivers/infiniband/hw/efa/efa_verbs.c         |  67 ++++++-
>>  include/uapi/rdma/efa-abi.h                   |  18 +-
>>  11 files changed, 636 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
>> index 87b1dadeb7fe..587d4bfbb3d1 100644
>> --- a/drivers/infiniband/hw/efa/efa.h
>> +++ b/drivers/infiniband/hw/efa/efa.h
>> @@ -20,14 +20,14 @@
>>  
>>  #define EFA_IRQNAME_SIZE        40
>>  
>> -/* 1 for AENQ + ADMIN */
>> -#define EFA_NUM_MSIX_VEC                  1
>>  #define EFA_MGMNT_MSIX_VEC_IDX            0
>> +#define EFA_COMP_EQS_VEC_BASE             1
>>  
>>  struct efa_irq {
>>  	irq_handler_t handler;
>>  	void *data;
>>  	u32 irqn;
>> +	u32 vector;
>>  	cpumask_t affinity_hint_mask;
>>  	char name[EFA_IRQNAME_SIZE];
>>  };
>> @@ -61,6 +61,13 @@ struct efa_dev {
>>  	struct efa_irq admin_irq;
>>  
>>  	struct efa_stats stats;
>> +
>> +	/* Array of completion EQs */
>> +	struct efa_eq *eqs;
>> +	unsigned int neqs;
>> +
>> +	/* Only stores CQs with interrupts enabled */
>> +	struct xarray cqs_xa;
>>  };
>>  
>>  struct efa_ucontext {
>> @@ -84,8 +91,11 @@ struct efa_cq {
>>  	dma_addr_t dma_addr;
>>  	void *cpu_addr;
>>  	struct rdma_user_mmap_entry *mmap_entry;
>> +	struct rdma_user_mmap_entry *db_mmap_entry;
>>  	size_t size;
>>  	u16 cq_idx;
>> +	/* NULL  when no interrupts requested */
>> +	struct efa_eq *eq;
>>  };
>>  
>>  struct efa_qp {
>> @@ -116,6 +126,11 @@ struct efa_ah {
>>  	u8 id[EFA_GID_SIZE];
>>  };
>>  
>> +struct efa_eq {
>> +	struct efa_com_eq eeq;
>> +	struct efa_irq irq;
>> +};
>> +
>>  int efa_query_device(struct ib_device *ibdev,
>>  		     struct ib_device_attr *props,
>>  		     struct ib_udata *udata);
>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> index fa38b34eddb8..0b0b93b529f3 100644
>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> @@ -28,7 +28,9 @@ enum efa_admin_aq_opcode {
>>  	EFA_ADMIN_DEALLOC_PD                        = 15,
>>  	EFA_ADMIN_ALLOC_UAR                         = 16,
>>  	EFA_ADMIN_DEALLOC_UAR                       = 17,
>> -	EFA_ADMIN_MAX_OPCODE                        = 17,
>> +	EFA_ADMIN_CREATE_EQ                         = 18,
>> +	EFA_ADMIN_DESTROY_EQ                        = 19,
>> +	EFA_ADMIN_MAX_OPCODE                        = 19,
>>  };
>>  
>>  enum efa_admin_aq_feature_id {
>> @@ -38,6 +40,7 @@ enum efa_admin_aq_feature_id {
>>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
>>  	EFA_ADMIN_HW_HINTS                          = 5,
>>  	EFA_ADMIN_HOST_INFO                         = 6,
>> +	EFA_ADMIN_EVENT_QUEUE_ATTR                  = 7,
>>  };
>>  
>>  /* QP transport type */
>> @@ -430,8 +433,8 @@ struct efa_admin_create_cq_cmd {
>>  	/*
>>  	 * 4:0 : reserved5 - MBZ
>>  	 * 5 : interrupt_mode_enabled - if set, cq operates
>> -	 *    in interrupt mode (i.e. CQ events and MSI-X are
>> -	 *    generated), otherwise - polling
>> +	 *    in interrupt mode (i.e. CQ events and EQ elements
>> +	 *    are generated), otherwise - polling
>>  	 * 6 : virt - If set, ring base address is virtual
>>  	 *    (IOVA returned by MR registration)
>>  	 * 7 : reserved6 - MBZ
>> @@ -448,8 +451,11 @@ struct efa_admin_create_cq_cmd {
>>  	/* completion queue depth in # of entries. must be power of 2 */
>>  	u16 cq_depth;
>>  
>> -	/* msix vector assigned to this cq */
>> -	u32 msix_vector_idx;
>> +	/* EQ number assigned to this cq */
>> +	u16 eqn;
>> +
>> +	/* MBZ */
>> +	u16 reserved;
>>  
>>  	/*
>>  	 * CQ ring base address, virtual or physical depending on 'virt'
>> @@ -480,6 +486,15 @@ struct efa_admin_create_cq_resp {
>>  
>>  	/* actual cq depth in number of entries */
>>  	u16 cq_actual_depth;
>> +
>> +	/* CQ doorbell address, as offset to PCIe DB BAR */
>> +	u32 db_offset;
>> +
>> +	/*
>> +	 * 0 : db_valid - If set, doorbell offset is valid.
>> +	 *    Always set when interrupts are requested.
>> +	 */
>> +	u32 flags;
>>  };
>>  
>>  struct efa_admin_destroy_cq_cmd {
>> @@ -669,6 +684,17 @@ struct efa_admin_feature_queue_attr_desc {
>>  	u16 max_tx_batch;
>>  };
>>  
>> +struct efa_admin_event_queue_attr_desc {
>> +	/* The maximum number of event queues supported */
>> +	u32 max_eq;
>> +
>> +	/* Maximum number of EQEs per Event Queue */
>> +	u32 max_eq_depth;
>> +
>> +	/* Supported events bitmask */
>> +	u32 event_bitmask;
>> +};
>> +
>>  struct efa_admin_feature_aenq_desc {
>>  	/* bitmask for AENQ groups the device can report */
>>  	u32 supported_groups;
>> @@ -727,6 +753,8 @@ struct efa_admin_get_feature_resp {
>>  
>>  		struct efa_admin_feature_queue_attr_desc queue_attr;
>>  
>> +		struct efa_admin_event_queue_attr_desc event_queue_attr;
>> +
>>  		struct efa_admin_hw_hints hw_hints;
>>  	} u;
>>  };
>> @@ -810,6 +838,60 @@ struct efa_admin_dealloc_uar_resp {
>>  	struct efa_admin_acq_common_desc acq_common_desc;
>>  };
>>  
>> +struct efa_admin_create_eq_cmd {
>> +	struct efa_admin_aq_common_desc aq_common_descriptor;
>> +
>> +	/* Size of the EQ in entries, must be power of 2 */
>> +	u16 depth;
>> +
>> +	/* MSI-X table entry index */
>> +	u8 msix_vec;
>> +
>> +	/*
>> +	 * 4:0 : entry_size_words - size of EQ entry in
>> +	 *    32-bit words
>> +	 * 7:5 : reserved - MBZ
>> +	 */
>> +	u8 caps;
>> +
>> +	/* EQ ring base address */
>> +	struct efa_common_mem_addr ba;
>> +
>> +	/*
>> +	 * Enabled events on this EQ
>> +	 * 0 : completion_events - Enable completion events
>> +	 * 31:1 : reserved - MBZ
>> +	 */
>> +	u32 event_bitmask;
>> +
>> +	/* MBZ */
>> +	u32 reserved;
>> +};
>> +
>> +struct efa_admin_create_eq_resp {
>> +	struct efa_admin_acq_common_desc acq_common_desc;
>> +
>> +	/* EQ number */
>> +	u16 eqn;
>> +
>> +	/* MBZ */
>> +	u16 reserved;
>> +};
>> +
>> +struct efa_admin_destroy_eq_cmd {
>> +	struct efa_admin_aq_common_desc aq_common_descriptor;
>> +
>> +	/* EQ number */
>> +	u16 eqn;
>> +
>> +	/* MBZ */
>> +	u16 reserved;
>> +};
>> +
>> +struct efa_admin_destroy_eq_resp {
>> +	struct efa_admin_acq_common_desc acq_common_desc;
>> +};
>> +
>>  /* asynchronous event notification groups */
>>  enum efa_admin_aenq_group {
>>  	EFA_ADMIN_FATAL_ERROR                       = 1,
>> @@ -899,10 +981,18 @@ struct efa_admin_host_info {
>>  #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
>>  #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
>>  
>> +/* create_cq_resp */
>> +#define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
>> +
>>  /* feature_device_attr_desc */
>>  #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
>>  #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
>>  
>> +/* create_eq_cmd */
>> +#define EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS_MASK       GENMASK(4, 0)
>> +#define EFA_ADMIN_CREATE_EQ_CMD_VIRT_MASK                   BIT(6)
>> +#define EFA_ADMIN_CREATE_EQ_CMD_COMPLETION_EVENTS_MASK      BIT(0)
>> +
>>  /* host_info */
>>  #define EFA_ADMIN_HOST_INFO_DRIVER_MODULE_TYPE_MASK         GENMASK(7, 0)
>>  #define EFA_ADMIN_HOST_INFO_DRIVER_SUB_MINOR_MASK           GENMASK(15, 8)
>> diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
>> index 78ff9389ae25..83f20c38a840 100644
>> --- a/drivers/infiniband/hw/efa/efa_admin_defs.h
>> +++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
>> @@ -118,6 +118,43 @@ struct efa_admin_aenq_entry {
>>  	u32 inline_data_w4[12];
>>  };
>>  
>> +enum efa_admin_eqe_event_type {
>> +	EFA_ADMIN_EQE_EVENT_TYPE_COMPLETION         = 0,
>> +};
>> +
>> +/* Completion event */
>> +struct efa_admin_comp_event {
>> +	/* CQ number */
>> +	u16 cqn;
>> +
>> +	/* MBZ */
>> +	u16 reserved;
>> +
>> +	/* MBZ */
>> +	u32 reserved2;
>> +};
>> +
>> +/* Event Queue Element */
>> +struct efa_admin_eqe {
>> +	/*
>> +	 * 0 : phase
>> +	 * 8:1 : event_type - Event type
>> +	 * 31:9 : reserved - MBZ
>> +	 */
>> +	u32 common;
>> +
>> +	/* MBZ */
>> +	u32 reserved;
>> +
>> +	union {
>> +		/* Event data */
>> +		u32 event_data[2];
>> +
>> +		/* Completion Event */
>> +		struct efa_admin_comp_event comp_event;
>> +	} u;
>> +};
>> +
>>  /* aq_common_desc */
>>  #define EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK            GENMASK(11, 0)
>>  #define EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK                 BIT(0)
>> @@ -131,4 +168,8 @@ struct efa_admin_aenq_entry {
>>  /* aenq_common_desc */
>>  #define EFA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
>>  
>> +/* eqe */
>> +#define EFA_ADMIN_EQE_PHASE_MASK                            BIT(0)
>> +#define EFA_ADMIN_EQE_EVENT_TYPE_MASK                       GENMASK(8, 1)
>> +
>>  #endif /* _EFA_ADMIN_H_ */
>> diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
>> index 0d523ad736c7..c00c7f526067 100644
>> --- a/drivers/infiniband/hw/efa/efa_com.c
>> +++ b/drivers/infiniband/hw/efa/efa_com.c
>> @@ -56,11 +56,19 @@ static const char *efa_com_cmd_str(u8 cmd)
>>  	EFA_CMD_STR_CASE(DEALLOC_PD);
>>  	EFA_CMD_STR_CASE(ALLOC_UAR);
>>  	EFA_CMD_STR_CASE(DEALLOC_UAR);
>> +	EFA_CMD_STR_CASE(CREATE_EQ);
>> +	EFA_CMD_STR_CASE(DESTROY_EQ);
>>  	default: return "unknown command opcode";
>>  	}
>>  #undef EFA_CMD_STR_CASE
>>  }
>>  
>> +void efa_com_set_dma_addr(dma_addr_t addr, u32 *addr_high, u32 *addr_low)
>> +{
>> +	*addr_low = lower_32_bits(addr);
>> +	*addr_high = upper_32_bits(addr);
>> +}
>> +
>>  static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
>>  {
>>  	struct efa_com_mmio_read *mmio_read = &edev->mmio_read;
>> @@ -1081,3 +1089,166 @@ int efa_com_dev_reset(struct efa_com_dev *edev,
>>  
>>  	return 0;
>>  }
>> +
>> +static int efa_com_create_eq(struct efa_com_dev *edev,
>> +			     struct efa_com_create_eq_params *params,
>> +			     struct efa_com_create_eq_result *result)
>> +{
>> +	struct efa_com_admin_queue *aq = &edev->aq;
>> +	struct efa_admin_create_eq_resp resp = {};
>> +	struct efa_admin_create_eq_cmd cmd = {};
>> +	int err;
>> +
>> +	cmd.aq_common_descriptor.opcode = EFA_ADMIN_CREATE_EQ;
>> +	EFA_SET(&cmd.caps, EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS,
>> +		params->entry_size_in_bytes / 4);
>> +	cmd.depth = params->depth;
>> +	cmd.event_bitmask = params->event_bitmask;
>> +	cmd.msix_vec = params->msix_vec;
>> +
>> +	efa_com_set_dma_addr(params->dma_addr, &cmd.ba.mem_addr_high,
>> +			     &cmd.ba.mem_addr_low);
>> +
>> +	err = efa_com_cmd_exec(aq,
>> +			       (struct efa_admin_aq_entry *)&cmd,
>> +			       sizeof(cmd),
>> +			       (struct efa_admin_acq_entry *)&resp,
>> +			       sizeof(resp));
>> +	if (err) {
>> +		ibdev_err_ratelimited(edev->efa_dev,
>> +				      "Failed to create eq[%d]\n", err);
>> +		return err;
>> +	}
>> +
>> +	result->eqn = resp.eqn;
>> +
>> +	return 0;
>> +}
>> +
>> +static int efa_com_destroy_eq(struct efa_com_dev *edev,
>> +			      struct efa_com_destroy_eq_params *params)
>> +{
> 
> Single caller of this function is not interested in return value from
> this function. It is worth to make it void from the beginning.

Thanks, will change.
