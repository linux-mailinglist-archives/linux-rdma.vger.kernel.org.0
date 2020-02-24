Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8131E16ABCB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXQje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:39:34 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.225]:37323 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbgBXQje (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 11:39:34 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D5EE2A6BB
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 10:39:32 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6GlYjYKV1RP4z6GlYjxVoD; Mon, 24 Feb 2020 10:39:32 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9MaTLdhyE2lqQeKKEie4NEqJq9AQ+rH9XoGJxwhMLV0=; b=FdNeV6gsZdQPOoKmEq9XL5aIW1
        57t9bacLPIHttu4CgT/3YNYmaHVDKnCZiWFdysBXPGLxBx2atz87M/rLEp0IV+eaYD4Hb/OUI6tSX
        Kxb0KZ+MPk4TAgJ2J65jtD8qUIm07AUvmo1CwIRioDG06xmIP9X2b2FSGV5HBNPlUXkDuCVxvzPC7
        rmO58X2jgu2tQ6wv3nEkaNYoYyoc17SUjds1cqP/wwL5Y9fyfG3dFZdPzT1K3GK7Nefa827fPuECs
        1xHqJdhvtqC2eKSNUvVzbNCT1cmo98sl5q268Z3G1Apg1+cjXAUCDDlC6OsBW9JrPi/gEwaFxdTC/
        RZ2nZkmA==;
Received: from [200.68.140.135] (port=33450 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j6GlY-002tup-0H; Mon, 24 Feb 2020 10:39:32 -0600
Subject: Re: [PATCH] scsi: Replace zero-length array with flexible-array
 member
To:     Lee Duncan <lduncan@suse.com>, Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Chris Leech <cleech@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, open-iscsi@googlegroups.com,
        linux-rdma@vger.kernel.org
References: <20200224161406.GA21454@embeddedor>
 <b44f60b7-3091-592e-b319-a929bcd19486@suse.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <026b4947-e38b-6d23-d330-414aebb19735@embeddedor.com>
Date:   Mon, 24 Feb 2020 10:42:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b44f60b7-3091-592e-b319-a929bcd19486@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.135
X-Source-L: No
X-Exim-ID: 1j6GlY-002tup-0H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [200.68.140.135]:33450
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 85
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/24/20 10:30, Lee Duncan wrote:
> On 2/24/20 8:14 AM, Gustavo A. R. Silva wrote:
>> The current codebase makes use of the zero-length array language
>> extension to the C90 standard, but the preferred mechanism to declare
>> variable-length types such as these ones is a flexible array member[1][2],
>> introduced in C99:
>>
>> struct foo {
>>         int stuff;
>>         struct boo array[];
>> };
>>
>> By making use of the mechanism above, we will get a compiler warning
>> in case the flexible array does not occur last in the structure, which
>> will help us prevent some kind of undefined behavior bugs from being
>> inadvertently introduced[3] to the codebase from now on.
>>
>> Also, notice that, dynamic memory allocations won't be affected by
>> this change:
>>
>> "Flexible array members have incomplete type, and so the sizeof operator
>> may not be applied. As a quirk of the original implementation of
>> zero-length arrays, sizeof evaluates to zero."[1]
>>
>> This issue was found with the help of Coccinelle.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  ...
>> diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
>> index 92b11c7e0b4f..b0e240b10bf9 100644
>> --- a/include/scsi/iscsi_if.h
>> +++ b/include/scsi/iscsi_if.h
>> @@ -311,7 +311,7 @@ enum iscsi_param_type {
>>  struct iscsi_param_info {
>>  	uint32_t len;		/* Actual length of the param value */
>>  	uint16_t param;		/* iscsi param */
>> -	uint8_t value[0];	/* length sized value follows */
>> +	uint8_t value[];	/* length sized value follows */
>>  } __packed;
>>  
>>  struct iscsi_iface_param_info {
>> @@ -320,7 +320,7 @@ struct iscsi_iface_param_info {
>>  	uint16_t param;		/* iscsi param value */
>>  	uint8_t iface_type;	/* IPv4 or IPv6 */
>>  	uint8_t param_type;	/* iscsi_param_type */
>> -	uint8_t value[0];	/* length sized value follows */
>> +	uint8_t value[];	/* length sized value follows */
>>  } __packed;
>>  
>>  /*
>> @@ -697,7 +697,7 @@ enum iscsi_flashnode_param {
>>  struct iscsi_flashnode_param_info {
>>  	uint32_t len;		/* Actual length of the param */
>>  	uint16_t param;		/* iscsi param value */
>> -	uint8_t value[0];	/* length sized value follows */
>> +	uint8_t value[];	/* length sized value follows */
>>  } __packed;
>>  
>>  enum iscsi_discovery_parent_type {
>> @@ -815,7 +815,7 @@ struct iscsi_stats {
>>  	 * up to ISCSI_STATS_CUSTOM_MAX
>>  	 */
>>  	uint32_t custom_length;
>> -	struct iscsi_stats_custom custom[0]
>> +	struct iscsi_stats_custom custom[]
>>  		__attribute__ ((aligned (sizeof(uint64_t))));
>>  };
>>  
>> @@ -946,7 +946,7 @@ struct iscsi_offload_host_stats {
>>  	 * up to ISCSI_HOST_STATS_CUSTOM_MAX
>>  	 */
>>  	uint32_t custom_length;
>> -	struct iscsi_host_stats_custom custom[0]
>> +	struct iscsi_host_stats_custom custom[]
>>  		__aligned(sizeof(uint64_t));
>>  };
>>  
>> diff --git a/include/scsi/scsi_bsg_iscsi.h b/include/scsi/scsi_bsg_iscsi.h
>> index fa0c820a1663..6b8128005af8 100644
>> --- a/include/scsi/scsi_bsg_iscsi.h
>> +++ b/include/scsi/scsi_bsg_iscsi.h
>> @@ -52,7 +52,7 @@ struct iscsi_bsg_host_vendor {
>>  	uint64_t vendor_id;
>>  
>>  	/* start of vendor command area */
>> -	uint32_t vendor_cmd[0];
>> +	uint32_t vendor_cmd[];
>>  };
>>  
>>  /* Response:
>> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
>> index f8312a3e5b42..4dc158cf09b8 100644
>> --- a/include/scsi/scsi_device.h
>> +++ b/include/scsi/scsi_device.h
>> @@ -231,7 +231,7 @@ struct scsi_device {
>>  	struct mutex		state_mutex;
>>  	enum scsi_device_state sdev_state;
>>  	struct task_struct	*quiesced_by;
>> -	unsigned long		sdev_data[0];
>> +	unsigned long		sdev_data[];
>>  } __attribute__((aligned(sizeof(unsigned long))));
>>  
>>  #define	to_scsi_device(d)	\
>> @@ -315,7 +315,7 @@ struct scsi_target {
>>  	char			scsi_level;
>>  	enum scsi_target_state	state;
>>  	void 			*hostdata; /* available to low-level driver */
>> -	unsigned long		starget_data[0]; /* for the transport */
>> +	unsigned long		starget_data[]; /* for the transport */
>>  	/* starget_data must be the last element!!!! */
>>  } __attribute__((aligned(sizeof(unsigned long))));
>>  
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 7a97fb8104cf..e6811ea8f984 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -682,7 +682,7 @@ struct Scsi_Host {
>>  	 * and also because some compilers (m68k) don't automatically force
>>  	 * alignment to a long boundary.
>>  	 */
>> -	unsigned long hostdata[0]  /* Used for storage of host specific stuff */
>> +	unsigned long hostdata[]  /* Used for storage of host specific stuff */
>>  		__attribute__ ((aligned (sizeof(unsigned long))));
>>  };
>>  
>> diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
>> index 4fe69d863b5d..b465799f4d2d 100644
>> --- a/include/scsi/scsi_ioctl.h
>> +++ b/include/scsi/scsi_ioctl.h
>> @@ -27,7 +27,7 @@ struct scsi_device;
>>  typedef struct scsi_ioctl_command {
>>  	unsigned int inlen;
>>  	unsigned int outlen;
>> -	unsigned char data[0];
>> +	unsigned char data[];
>>  } Scsi_Ioctl_Command;
>>  
>>  typedef struct scsi_idlun {
>> diff --git a/include/scsi/srp.h b/include/scsi/srp.h
>> index 9220758d5087..177d8026e96f 100644
>> --- a/include/scsi/srp.h
>> +++ b/include/scsi/srp.h
>> @@ -109,7 +109,7 @@ struct srp_direct_buf {
>>  struct srp_indirect_buf {
>>  	struct srp_direct_buf	table_desc;
>>  	__be32			len;
>> -	struct srp_direct_buf	desc_list[0];
>> +	struct srp_direct_buf	desc_list[];
>>  } __attribute__((packed));
>>  
>>  /* Immediate data buffer descriptor as defined in SRP2. */
>> @@ -244,7 +244,7 @@ struct srp_cmd {
>>  	u8	reserved4;
>>  	u8	add_cdb_len;
>>  	u8	cdb[16];
>> -	u8	add_data[0];
>> +	u8	add_data[];
>>  };
>>  
>>  enum {
>> @@ -274,7 +274,7 @@ struct srp_rsp {
>>  	__be32	data_in_res_cnt;
>>  	__be32	sense_data_len;
>>  	__be32	resp_data_len;
>> -	u8	data[0];
>> +	u8	data[];
>>  } __attribute__((packed));
>>  
>>  struct srp_cred_req {
>> @@ -306,7 +306,7 @@ struct srp_aer_req {
>>  	struct scsi_lun	lun;
>>  	__be32	sense_data_len;
>>  	u32	reserved3;
>> -	u8	sense_data[0];
>> +	u8	sense_data[];
>>  } __attribute__((packed));
>>  
>>  struct srp_aer_rsp {
>> diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
>> index 3ae65e93235c..7f5930801f72 100644
>> --- a/include/uapi/scsi/scsi_bsg_fc.h
>> +++ b/include/uapi/scsi/scsi_bsg_fc.h
>> @@ -209,7 +209,7 @@ struct fc_bsg_host_vendor {
>>  	__u64 vendor_id;
>>  
>>  	/* start of vendor command area */
>> -	__u32 vendor_cmd[0];
>> +	__u32 vendor_cmd[];
>>  };
>>  
>>  /* Response:
>>
> 
> Reviewed-by: Lee Duncan <lduncan@suse.com>
> 

Thanks, Lee.

--
Gustavo
