Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15116ABAF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXQe0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:34:26 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.87]:43477 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727299AbgBXQeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 11:34:25 -0500
X-Greylist: delayed 1385 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:34:24 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 2A05C1219EE
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 10:11:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6GKFjEhUcXVkQ6GKFjaNLf; Mon, 24 Feb 2020 10:11:19 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7e28GVAyaL5GQzoBarUOu44L4v9JQuyAxSP9Znha/Wk=; b=puN1Lussep5gXOv/gmquixC6bQ
        uGkaPq4clH1SG9fvZzyt4GM0BMPmrr5U7x4sDkMrDPqIld+Nx8mDr1QnsaY7pwAqk93c9ktb+EbjD
        V8t2SsudejtcX5MPaNZrpT9wzjVvzIFa22O62xaxfJ5XVuo+Lbox2S3gKdI8o53oNCmtNgi0yjZAL
        O9Wikro0wr320gWtWMzj+WHHdZPDmE+H+xgBJgQsyQkL9lakmiWx57dWvc2Ji6V0KwwrTDb9LKEUf
        hTKcafblNzcqJFFIOM1mC7LTuD+3z+a/O0qmF+E5CO2gfPT/4ObsWSGV0mNZJsVpJlE2QLiLnU75y
        ehZ3mEHw==;
Received: from [200.68.140.135] (port=3410 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j6GKC-002dTZ-Uk; Mon, 24 Feb 2020 10:11:17 -0600
Date:   Mon, 24 Feb 2020 10:14:06 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Satish Kharat <satishkh@cisco.com>,
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
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, open-iscsi@googlegroups.com,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: Replace zero-length array with flexible-array member
Message-ID: <20200224161406.GA21454@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.135
X-Source-L: No
X-Exim-ID: 1j6GKC-002dTZ-Uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.135]:3410
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/fnic/vnic_devcmd.h      |  2 +-
 drivers/scsi/ipr.h                   |  6 +++---
 drivers/scsi/isci/sas.h              |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  2 +-
 drivers/scsi/mvsas/mv_sas.h          |  2 +-
 drivers/scsi/mvumi.h                 |  4 ++--
 drivers/scsi/pmcraid.h               |  2 +-
 drivers/scsi/snic/vnic_devcmd.h      |  2 +-
 drivers/scsi/stex.c                  |  2 +-
 include/scsi/iscsi_if.h              | 10 +++++-----
 include/scsi/scsi_bsg_iscsi.h        |  2 +-
 include/scsi/scsi_device.h           |  4 ++--
 include/scsi/scsi_host.h             |  2 +-
 include/scsi/scsi_ioctl.h            |  2 +-
 include/scsi/srp.h                   |  8 ++++----
 include/uapi/scsi/scsi_bsg_fc.h      |  2 +-
 16 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_devcmd.h b/drivers/scsi/fnic/vnic_devcmd.h
index c5dde556dc7c..c20d30e36dfc 100644
--- a/drivers/scsi/fnic/vnic_devcmd.h
+++ b/drivers/scsi/fnic/vnic_devcmd.h
@@ -442,7 +442,7 @@ struct vnic_devcmd_notify {
 struct vnic_devcmd_provinfo {
 	u8 oui[3];
 	u8 type;
-	u8 data[0];
+	u8 data[];
 };
 
 /*
diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index a67baeb36d1f..fd3929a19ab5 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -451,12 +451,12 @@ struct ipr_config_table_hdr64 {
 
 struct ipr_config_table {
 	struct ipr_config_table_hdr hdr;
-	struct ipr_config_table_entry dev[0];
+	struct ipr_config_table_entry dev[];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_config_table64 {
 	struct ipr_config_table_hdr64 hdr64;
-	struct ipr_config_table_entry64 dev[0];
+	struct ipr_config_table_entry64 dev[];
 }__attribute__((packed, aligned (8)));
 
 struct ipr_config_table_entry_wrapper {
@@ -792,7 +792,7 @@ struct ipr_mode_page28 {
 	struct ipr_mode_page_hdr hdr;
 	u8 num_entries;
 	u8 entry_length;
-	struct ipr_dev_bus_entry bus[0];
+	struct ipr_dev_bus_entry bus[];
 }__attribute__((packed));
 
 struct ipr_mode_page24 {
diff --git a/drivers/scsi/isci/sas.h b/drivers/scsi/isci/sas.h
index dc26b4aea99e..15d8f3631ab7 100644
--- a/drivers/scsi/isci/sas.h
+++ b/drivers/scsi/isci/sas.h
@@ -201,7 +201,7 @@ struct smp_req {
 	u8 func;		/* byte 1 */
 	u8 alloc_resp_len;	/* byte 2 */
 	u8 req_len;		/* byte 3 */
-	u8 req_data[0];
+	u8 req_data[];
 }  __packed;
 
 /*
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c597d544eb39..778d5e6ce385 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -207,7 +207,7 @@ struct fw_event_work {
 	u8			ignore;
 	u16			event;
 	struct kref		refcount;
-	char			event_data[0] __aligned(4);
+	char			event_data[] __aligned(4);
 };
 
 static void fw_event_work_free(struct kref *r)
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 519edc796691..327fdd5ee962 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -394,7 +394,7 @@ struct mvs_info {
 	dma_addr_t bulk_buffer_dma1;
 #define TRASH_BUCKET_SIZE    	0x20000
 	void *dma_pool;
-	struct mvs_slot_info slot_info[0];
+	struct mvs_slot_info slot_info[];
 };
 
 struct mvs_prv_info{
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index ec8cc2207536..60d5691fc4ab 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -130,7 +130,7 @@ enum {
 struct mvumi_hotplug_event {
 	u16 size;
 	u8 dummy[2];
-	u8 bitmap[0];
+	u8 bitmap[];
 };
 
 struct mvumi_driver_event {
@@ -290,7 +290,7 @@ struct mvumi_rsp_frame {
 
 struct mvumi_ob_data {
 	struct list_head list;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 struct version_info {
diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index a4f7eb8f50a3..15c962108075 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -623,7 +623,7 @@ struct pmcraid_aen_msg {
 	u32 hostno;
 	u32 length;
 	u8  reserved[8];
-	u8  data[0];
+	u8  data[];
 };
 
 /* Controller state event message type */
diff --git a/drivers/scsi/snic/vnic_devcmd.h b/drivers/scsi/snic/vnic_devcmd.h
index d81b4f0ceaaa..0e0fa38f8d90 100644
--- a/drivers/scsi/snic/vnic_devcmd.h
+++ b/drivers/scsi/snic/vnic_devcmd.h
@@ -208,7 +208,7 @@ struct vnic_devcmd_notify {
 struct vnic_devcmd_provinfo {
 	u8 oui[3];
 	u8 type;
-	u8 data[0];
+	u8 data[];
 };
 
 /*
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 33287b6bdf0e..d4f10c0d813c 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -236,7 +236,7 @@ struct req_msg {
 	u8 data_dir;
 	u8 payload_sz;		/* payload size in 4-byte, not used */
 	u8 cdb[STEX_CDB_LENGTH];
-	u32 variable[0];
+	u32 variable[];
 };
 
 struct status_msg {
diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
index 92b11c7e0b4f..b0e240b10bf9 100644
--- a/include/scsi/iscsi_if.h
+++ b/include/scsi/iscsi_if.h
@@ -311,7 +311,7 @@ enum iscsi_param_type {
 struct iscsi_param_info {
 	uint32_t len;		/* Actual length of the param value */
 	uint16_t param;		/* iscsi param */
-	uint8_t value[0];	/* length sized value follows */
+	uint8_t value[];	/* length sized value follows */
 } __packed;
 
 struct iscsi_iface_param_info {
@@ -320,7 +320,7 @@ struct iscsi_iface_param_info {
 	uint16_t param;		/* iscsi param value */
 	uint8_t iface_type;	/* IPv4 or IPv6 */
 	uint8_t param_type;	/* iscsi_param_type */
-	uint8_t value[0];	/* length sized value follows */
+	uint8_t value[];	/* length sized value follows */
 } __packed;
 
 /*
@@ -697,7 +697,7 @@ enum iscsi_flashnode_param {
 struct iscsi_flashnode_param_info {
 	uint32_t len;		/* Actual length of the param */
 	uint16_t param;		/* iscsi param value */
-	uint8_t value[0];	/* length sized value follows */
+	uint8_t value[];	/* length sized value follows */
 } __packed;
 
 enum iscsi_discovery_parent_type {
@@ -815,7 +815,7 @@ struct iscsi_stats {
 	 * up to ISCSI_STATS_CUSTOM_MAX
 	 */
 	uint32_t custom_length;
-	struct iscsi_stats_custom custom[0]
+	struct iscsi_stats_custom custom[]
 		__attribute__ ((aligned (sizeof(uint64_t))));
 };
 
@@ -946,7 +946,7 @@ struct iscsi_offload_host_stats {
 	 * up to ISCSI_HOST_STATS_CUSTOM_MAX
 	 */
 	uint32_t custom_length;
-	struct iscsi_host_stats_custom custom[0]
+	struct iscsi_host_stats_custom custom[]
 		__aligned(sizeof(uint64_t));
 };
 
diff --git a/include/scsi/scsi_bsg_iscsi.h b/include/scsi/scsi_bsg_iscsi.h
index fa0c820a1663..6b8128005af8 100644
--- a/include/scsi/scsi_bsg_iscsi.h
+++ b/include/scsi/scsi_bsg_iscsi.h
@@ -52,7 +52,7 @@ struct iscsi_bsg_host_vendor {
 	uint64_t vendor_id;
 
 	/* start of vendor command area */
-	uint32_t vendor_cmd[0];
+	uint32_t vendor_cmd[];
 };
 
 /* Response:
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index f8312a3e5b42..4dc158cf09b8 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -231,7 +231,7 @@ struct scsi_device {
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
 	struct task_struct	*quiesced_by;
-	unsigned long		sdev_data[0];
+	unsigned long		sdev_data[];
 } __attribute__((aligned(sizeof(unsigned long))));
 
 #define	to_scsi_device(d)	\
@@ -315,7 +315,7 @@ struct scsi_target {
 	char			scsi_level;
 	enum scsi_target_state	state;
 	void 			*hostdata; /* available to low-level driver */
-	unsigned long		starget_data[0]; /* for the transport */
+	unsigned long		starget_data[]; /* for the transport */
 	/* starget_data must be the last element!!!! */
 } __attribute__((aligned(sizeof(unsigned long))));
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7a97fb8104cf..e6811ea8f984 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -682,7 +682,7 @@ struct Scsi_Host {
 	 * and also because some compilers (m68k) don't automatically force
 	 * alignment to a long boundary.
 	 */
-	unsigned long hostdata[0]  /* Used for storage of host specific stuff */
+	unsigned long hostdata[]  /* Used for storage of host specific stuff */
 		__attribute__ ((aligned (sizeof(unsigned long))));
 };
 
diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
index 4fe69d863b5d..b465799f4d2d 100644
--- a/include/scsi/scsi_ioctl.h
+++ b/include/scsi/scsi_ioctl.h
@@ -27,7 +27,7 @@ struct scsi_device;
 typedef struct scsi_ioctl_command {
 	unsigned int inlen;
 	unsigned int outlen;
-	unsigned char data[0];
+	unsigned char data[];
 } Scsi_Ioctl_Command;
 
 typedef struct scsi_idlun {
diff --git a/include/scsi/srp.h b/include/scsi/srp.h
index 9220758d5087..177d8026e96f 100644
--- a/include/scsi/srp.h
+++ b/include/scsi/srp.h
@@ -109,7 +109,7 @@ struct srp_direct_buf {
 struct srp_indirect_buf {
 	struct srp_direct_buf	table_desc;
 	__be32			len;
-	struct srp_direct_buf	desc_list[0];
+	struct srp_direct_buf	desc_list[];
 } __attribute__((packed));
 
 /* Immediate data buffer descriptor as defined in SRP2. */
@@ -244,7 +244,7 @@ struct srp_cmd {
 	u8	reserved4;
 	u8	add_cdb_len;
 	u8	cdb[16];
-	u8	add_data[0];
+	u8	add_data[];
 };
 
 enum {
@@ -274,7 +274,7 @@ struct srp_rsp {
 	__be32	data_in_res_cnt;
 	__be32	sense_data_len;
 	__be32	resp_data_len;
-	u8	data[0];
+	u8	data[];
 } __attribute__((packed));
 
 struct srp_cred_req {
@@ -306,7 +306,7 @@ struct srp_aer_req {
 	struct scsi_lun	lun;
 	__be32	sense_data_len;
 	u32	reserved3;
-	u8	sense_data[0];
+	u8	sense_data[];
 } __attribute__((packed));
 
 struct srp_aer_rsp {
diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
index 3ae65e93235c..7f5930801f72 100644
--- a/include/uapi/scsi/scsi_bsg_fc.h
+++ b/include/uapi/scsi/scsi_bsg_fc.h
@@ -209,7 +209,7 @@ struct fc_bsg_host_vendor {
 	__u64 vendor_id;
 
 	/* start of vendor command area */
-	__u32 vendor_cmd[0];
+	__u32 vendor_cmd[];
 };
 
 /* Response:
-- 
2.25.0

