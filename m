Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B742716ABB5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXQfz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:35:55 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:51002 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727299AbgBXQfz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 11:35:55 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Mon, 24 Feb 2020 16:35:05 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 24 Feb 2020 16:31:06 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 24 Feb 2020 16:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgZO5Rfj88quCU9WXlH1bLtkgLuSO2Xg5qgCk20A/Bth932OdqlkBhmvzmmeu7XV+zQE8IcLx+MNRUYKE7a6iC46DQDZbniQ0a5MTM8m79xs1SwNHDHdbUuZGpD+y3yuqE5E4wEhZ+V/7aJgjm3iy+FDhVViLRQ1izadRkflunLgaaKyK6BbRsKyJ1iT8TZxKxudg3z5HtVkNtD6bFNRYk/U7SP2pmd7n7IDGypHnr/q7jCXr6FhbbdDX3EeIQ4gLV3cQ6hV7UQPiFmLsrV8AM3w4fi5vAL5+BgRwFPb+VJWuErN3WJC5ghHkBcRqW7oiwzckvAGJD8b2WDyM9z0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HR6pUWFkg+EcQburVmSFJycNDCLdx0/NXWpYcPhROw=;
 b=ZENs5hvC72KQ1ZzFxHdwEJrBwD2333frsXRbrRYzY4ZBmGI9FbV9JLFaPI/uyuYGxWqwhPtUr1TaUCYr/CcJquYTs+IOL+QBYAtrSRiJE6uRIguIgwIZHLTfC1wvRB7efO37uGonDmyzAqmgHWP9DnWdfMbGHlNnSICUf7vhH0fe0DdYg0La+lzGNRJC8s275/0KTbT+sLhrTdK4mLLYi9nmzACXiz+ZNkbtlFDklFpJ9m/x2iYR4h9hQLLnjGR+YK/YLqfCR99FFetAKnS9AtZJjzKe0sjjj112G5zE2+ezVrPPHixBvRvMCdny83NZIZSI3zyJPSCNM7WRJT8pwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=LDuncan@suse.com; 
Received: from MN2PR18MB3278.namprd18.prod.outlook.com (2603:10b6:208:168::12)
 by MN2PR18MB3496.namprd18.prod.outlook.com (2603:10b6:208:269::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 16:31:05 +0000
Received: from MN2PR18MB3278.namprd18.prod.outlook.com
 ([fe80::257e:4933:95ff:e316]) by MN2PR18MB3278.namprd18.prod.outlook.com
 ([fe80::257e:4933:95ff:e316%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 16:31:05 +0000
Subject: Re: [PATCH] scsi: Replace zero-length array with flexible-array
 member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Satish Kharat <satishkh@cisco.com>,
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
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <MPT-FusionLinux.pdl@broadcom.com>, <open-iscsi@googlegroups.com>,
        <linux-rdma@vger.kernel.org>
References: <20200224161406.GA21454@embeddedor>
From:   Lee Duncan <lduncan@suse.com>
Message-ID: <b44f60b7-3091-592e-b319-a929bcd19486@suse.com>
Date:   Mon, 24 Feb 2020 08:30:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200224161406.GA21454@embeddedor>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::36) To MN2PR18MB3278.namprd18.prod.outlook.com
 (2603:10b6:208:168::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.20.3] (73.25.22.216) by LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 16:30:59 +0000
X-Originating-IP: [73.25.22.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 955004f1-2185-4c35-2a01-08d7b946f196
X-MS-TrafficTypeDiagnostic: MN2PR18MB3496:
X-Microsoft-Antispam-PRVS: <MN2PR18MB3496B3A535E2FC4F7FBF09BFDAEC0@MN2PR18MB3496.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(26005)(86362001)(966005)(186003)(16526019)(36756003)(52116002)(6666004)(478600001)(8936002)(4326008)(7416002)(316002)(66946007)(81166006)(8676002)(81156014)(6486002)(2616005)(2906002)(956004)(31686004)(110136005)(53546011)(66556008)(66476007)(16576012)(31696002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB3496;H:MN2PR18MB3278.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DJcUpUKHs3xBrUjyykKQqfZbcrEnLBvMg7iQrhZCxci0ieGiA6vouTs0X4ki4WF6l26V8LTfBg9SZ0BHvOI0EjHnEGLOr+V85g1a/U399TPlynmZIOFZMH05OFORRmh7eM2T4MQCugEAlxmKZssmtJtYPnjz6MLmM1hKr7w0tWNaUwTAW+tN+ZPdjFbBgdu9omiapLgCItUIcFmc9LiNWzsP3LInhNYLU44P1QXtoVrfp6yVAzG/OGawOBRll5dWEWJ0SDXpUlKoa8PipFwvh1/bZgWDKosuPLaPodWfmJXfrD6ZBGTDonGfn/gbr59LshHB6ZhdhnjadwZg6TdiDY3QBapNIkS2vt6H+AmBK8ZPj/QCeUODZQCYwu+Fk02cWefCbuYKAimecmP6hm+a1ZNJ22zi4TwX0wUirfowFG6j3ApaLzdXJHLwkS19cxLUthOer7ut7Tvoh1apg7bhPJ8MuEAp8ldzkKo3PRS+G+fYtC3RmtE7pLkmz4Cybds8Q2V7BMpjF6f8cFa4+K5+94pGZ/CdKc16wYmbiYiCKDtpZpeVv8iw3MtpiuKkdWNIzCMFWl7wcIXi+7E4B2jFQ==
X-MS-Exchange-AntiSpam-MessageData: vTepvfULObDcHan0zqFIkMHmhiUT8+/KO2k5Sx+WYx1BVeuxSXEFCwF4Q+KzwQoq4mbfmB1kR+ffYk5Q+KuGMxJm8qLr3+6a90wrF5uhGYWGOTQC/cMNk+glxGgUKUw+a/NQKn4nXG42+1XnTfqKHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 955004f1-2185-4c35-2a01-08d7b946f196
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 16:31:05.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 544Z785+9IpSGObDTUov+bzAy2pt6JDvlenvpkCpf+UfZz9zF6H4JLvWQ5oiweN2ulT2F+XQpcK+Ir+e4lkpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3496
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/24/20 8:14 AM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  ...
> diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
> index 92b11c7e0b4f..b0e240b10bf9 100644
> --- a/include/scsi/iscsi_if.h
> +++ b/include/scsi/iscsi_if.h
> @@ -311,7 +311,7 @@ enum iscsi_param_type {
>  struct iscsi_param_info {
>  	uint32_t len;		/* Actual length of the param value */
>  	uint16_t param;		/* iscsi param */
> -	uint8_t value[0];	/* length sized value follows */
> +	uint8_t value[];	/* length sized value follows */
>  } __packed;
>  
>  struct iscsi_iface_param_info {
> @@ -320,7 +320,7 @@ struct iscsi_iface_param_info {
>  	uint16_t param;		/* iscsi param value */
>  	uint8_t iface_type;	/* IPv4 or IPv6 */
>  	uint8_t param_type;	/* iscsi_param_type */
> -	uint8_t value[0];	/* length sized value follows */
> +	uint8_t value[];	/* length sized value follows */
>  } __packed;
>  
>  /*
> @@ -697,7 +697,7 @@ enum iscsi_flashnode_param {
>  struct iscsi_flashnode_param_info {
>  	uint32_t len;		/* Actual length of the param */
>  	uint16_t param;		/* iscsi param value */
> -	uint8_t value[0];	/* length sized value follows */
> +	uint8_t value[];	/* length sized value follows */
>  } __packed;
>  
>  enum iscsi_discovery_parent_type {
> @@ -815,7 +815,7 @@ struct iscsi_stats {
>  	 * up to ISCSI_STATS_CUSTOM_MAX
>  	 */
>  	uint32_t custom_length;
> -	struct iscsi_stats_custom custom[0]
> +	struct iscsi_stats_custom custom[]
>  		__attribute__ ((aligned (sizeof(uint64_t))));
>  };
>  
> @@ -946,7 +946,7 @@ struct iscsi_offload_host_stats {
>  	 * up to ISCSI_HOST_STATS_CUSTOM_MAX
>  	 */
>  	uint32_t custom_length;
> -	struct iscsi_host_stats_custom custom[0]
> +	struct iscsi_host_stats_custom custom[]
>  		__aligned(sizeof(uint64_t));
>  };
>  
> diff --git a/include/scsi/scsi_bsg_iscsi.h b/include/scsi/scsi_bsg_iscsi.h
> index fa0c820a1663..6b8128005af8 100644
> --- a/include/scsi/scsi_bsg_iscsi.h
> +++ b/include/scsi/scsi_bsg_iscsi.h
> @@ -52,7 +52,7 @@ struct iscsi_bsg_host_vendor {
>  	uint64_t vendor_id;
>  
>  	/* start of vendor command area */
> -	uint32_t vendor_cmd[0];
> +	uint32_t vendor_cmd[];
>  };
>  
>  /* Response:
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index f8312a3e5b42..4dc158cf09b8 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -231,7 +231,7 @@ struct scsi_device {
>  	struct mutex		state_mutex;
>  	enum scsi_device_state sdev_state;
>  	struct task_struct	*quiesced_by;
> -	unsigned long		sdev_data[0];
> +	unsigned long		sdev_data[];
>  } __attribute__((aligned(sizeof(unsigned long))));
>  
>  #define	to_scsi_device(d)	\
> @@ -315,7 +315,7 @@ struct scsi_target {
>  	char			scsi_level;
>  	enum scsi_target_state	state;
>  	void 			*hostdata; /* available to low-level driver */
> -	unsigned long		starget_data[0]; /* for the transport */
> +	unsigned long		starget_data[]; /* for the transport */
>  	/* starget_data must be the last element!!!! */
>  } __attribute__((aligned(sizeof(unsigned long))));
>  
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 7a97fb8104cf..e6811ea8f984 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -682,7 +682,7 @@ struct Scsi_Host {
>  	 * and also because some compilers (m68k) don't automatically force
>  	 * alignment to a long boundary.
>  	 */
> -	unsigned long hostdata[0]  /* Used for storage of host specific stuff */
> +	unsigned long hostdata[]  /* Used for storage of host specific stuff */
>  		__attribute__ ((aligned (sizeof(unsigned long))));
>  };
>  
> diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
> index 4fe69d863b5d..b465799f4d2d 100644
> --- a/include/scsi/scsi_ioctl.h
> +++ b/include/scsi/scsi_ioctl.h
> @@ -27,7 +27,7 @@ struct scsi_device;
>  typedef struct scsi_ioctl_command {
>  	unsigned int inlen;
>  	unsigned int outlen;
> -	unsigned char data[0];
> +	unsigned char data[];
>  } Scsi_Ioctl_Command;
>  
>  typedef struct scsi_idlun {
> diff --git a/include/scsi/srp.h b/include/scsi/srp.h
> index 9220758d5087..177d8026e96f 100644
> --- a/include/scsi/srp.h
> +++ b/include/scsi/srp.h
> @@ -109,7 +109,7 @@ struct srp_direct_buf {
>  struct srp_indirect_buf {
>  	struct srp_direct_buf	table_desc;
>  	__be32			len;
> -	struct srp_direct_buf	desc_list[0];
> +	struct srp_direct_buf	desc_list[];
>  } __attribute__((packed));
>  
>  /* Immediate data buffer descriptor as defined in SRP2. */
> @@ -244,7 +244,7 @@ struct srp_cmd {
>  	u8	reserved4;
>  	u8	add_cdb_len;
>  	u8	cdb[16];
> -	u8	add_data[0];
> +	u8	add_data[];
>  };
>  
>  enum {
> @@ -274,7 +274,7 @@ struct srp_rsp {
>  	__be32	data_in_res_cnt;
>  	__be32	sense_data_len;
>  	__be32	resp_data_len;
> -	u8	data[0];
> +	u8	data[];
>  } __attribute__((packed));
>  
>  struct srp_cred_req {
> @@ -306,7 +306,7 @@ struct srp_aer_req {
>  	struct scsi_lun	lun;
>  	__be32	sense_data_len;
>  	u32	reserved3;
> -	u8	sense_data[0];
> +	u8	sense_data[];
>  } __attribute__((packed));
>  
>  struct srp_aer_rsp {
> diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
> index 3ae65e93235c..7f5930801f72 100644
> --- a/include/uapi/scsi/scsi_bsg_fc.h
> +++ b/include/uapi/scsi/scsi_bsg_fc.h
> @@ -209,7 +209,7 @@ struct fc_bsg_host_vendor {
>  	__u64 vendor_id;
>  
>  	/* start of vendor command area */
> -	__u32 vendor_cmd[0];
> +	__u32 vendor_cmd[];
>  };
>  
>  /* Response:
> 

Reviewed-by: Lee Duncan <lduncan@suse.com>
