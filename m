Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C709E216D9D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGNXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 09:23:39 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:24581
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgGGNXi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 09:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOkbgryuAdd+FxN+J1Ls+8CXPqbZDRjiNLOSLahK7yqKBMcRaph5Oe0Uay4g6Phy9jN0qaKPfcPZMI9kWakrkPpmkMsvZpirRxo43kx7+h80s8F2IZauae5RahGqrueNrdkUYvJDgR7q3dXVMlVZxAmspFu3DBx4U8f6zckQrBkKNOVMdDfu/q7Nl9Q25tOegCJ6qKxWSYxBcb5kYBCSSWFBcG2rEMYHH50Xy4fKqWuXBf1NgLixcVOzIAGslbgdemLKGtm3Wu9FvOOg2VTlMo40+3W2hIibJGkgA4OCmzISTLbM5oxJ5hQEW1BKdsf8VJpfiRUz84O6RJBjeMUSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlC/VTEsTJ4O1zN3B/44+1s9eGisBL3TT5G7Y6oiWHI=;
 b=fQPESraPXdZtkAy8nEBGXyYveYl3bvsoYWdpb0UIMk5zlOBntGhBVMaZ6dVRf+oCnsSzIZViV+gj9c1KTCBdtCCzeHhRUhsYm5x1SpPKowRAQldksJolTEuMgumPqDA8D/AMA0pvax0h3mc3jlS9XcFmoliTFNiQ/AdokDRVov76hGsfwCoi49mUQGEiObB+oDGXmNoV+Kr0qtnAxajrz/Md0ixQfZWvMy6DoRr8UZNiGvHrI2zAPUDWNPU2RAdK0X8xJiQfnexoa7rZyUmbMcKzwFAAgtI63yAv6WEPgaoVTvGg0NIwAlYUpkJufIG+mm7vuISgUFEmE9ZKlvvxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlC/VTEsTJ4O1zN3B/44+1s9eGisBL3TT5G7Y6oiWHI=;
 b=Nmz9+FUf3ITFC28ORsrRfKemhQDF8zL3cr23FQF5kVJPvyUyffcM5bVogjVBDhOASRbqeSGRVUyrRjrU8bX/ie/1jlZcKkSOzAJTS/xzdSclU4qUnpuK+jjb0teYquuV3jagN4JoPapgg6BEjB+wV8Otz5aJdRtnL150wBtdtfs=
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6243.eurprd05.prod.outlook.com (2603:10a6:208:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 13:23:33 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 13:23:33 +0000
Subject: Re: iSERT SQ overflow with single target and multi luns
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <20200707123641.GA22620@chelsio.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <58258370-dcb2-4745-ec87-8a65b594075d@mellanox.com>
Date:   Tue, 7 Jul 2020 16:23:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200707123641.GA22620@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:208:be::38) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.10] (46.116.90.232) by AM0PR04CA0097.eurprd04.prod.outlook.com (2603:10a6:208:be::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 13:23:32 +0000
X-Originating-IP: [46.116.90.232]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8df3285-b9c9-4273-5a46-08d82278f266
X-MS-TrafficTypeDiagnostic: AM0PR05MB6243:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6243BB9975D1BDDE771915C6B6660@AM0PR05MB6243.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsRS/wLEvv/v5uOmgXP+IEr2V1eP4pYT5SlDe87xCbVWdNJxh8vlFm7DWHj1OS0SM2EMV/eYuIFzMnbxIZ9q+QsqD1NTuIskaFYWEy5GavQ257J0yeUa3K1Rbr2ipdklxajZpb5iWcT2zTe6b/rv1meKR7ccKs4MIhX3vhyelUwrAn6E8mdYXQ6WbGhJ+XdYDxRkOnPKyYAWBlslT9saJpQ8ru3o1A10bv5/2WPqh2biqUM6h3EHA6AGl3gLgz3OXpxe7jNqeHrM6foMYBSdz+Su9NnIJrUcisbD5FUe0smIQ/3Wo+FV3icLqOxrxoNb3ELZCSRutV9TVQ9VjOZD++QP1YJp323BxT1LgjZKrH3LuYDouWICpCrX1Vgd6Uf/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(26005)(83380400001)(31686004)(4326008)(8936002)(110136005)(16526019)(16576012)(54906003)(2906002)(186003)(6486002)(2616005)(53546011)(956004)(5660300002)(8676002)(498600001)(86362001)(52116002)(36756003)(66476007)(66946007)(31696002)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SiPmicBltYR4g4v3eio48/V9jyI9otYj2bCxnIIQtMrVnhuxywwz/xqtGeAxrR9tQfeXateJSB3OCAY2uXeGyHQQpMIZZbkmiHMbHXAgt6/BadwZbkzJ8/tEOPJGjwBfrpd1VkV9t/W4pllx04r2PFeh/rbdAnR5R5C73Gvbv1fG5Igedeo2QXtH9UMu1qeTmrr8tiIwupuUTt6zqL+7V49PkqPLOc5Mqni7Zm6QZ2mWJuwppb8h6d5GFmVPXmM3VStIfHkQlqhjugPXyZtf9xWcJ3sTStvT/B7344As1FPyH0kaJNnGHjhC9yycYQpPvi2lfcsZwTLYoKjkJdYaTJz25ytroT05dqnq5xtotADB9vemTd5UUjgN1ey2TegqI2UEuZkYr+y0YMYrpaFRa4Lko+4vcIgyZkelmfjRJlE9AfmlkcuEEXLYz3eOVK17F9jffqzReaA11sg8ZdYkZlbURbYf0zd3fEB7xx76ECc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8df3285-b9c9-4273-5a46-08d82278f266
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 13:23:33.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UmgcMf9tyz3rCQvgokoE4xzxzn81yzkMlqiw/KLw4fAHaxYH847lxR9J/bJpGICn8evOkfykuV5aAUiHGGzqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6243
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Krishna,

thanks for debugging this.

please try the following untested patch:


diff --git a/drivers/infiniband/ulp/isert/ib_isert.c 
b/drivers/infiniband/ulp/isert/ib_isert.c
index b7df38e..49f5f05 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -119,7 +119,7 @@
  {
         struct isert_device *device = isert_conn->device;
         struct ib_qp_init_attr attr;
-       int ret;
+       int ret, factor;

         memset(&attr, 0, sizeof(struct ib_qp_init_attr));
         attr.event_handler = isert_qp_event_callback;
@@ -128,7 +128,9 @@
         attr.recv_cq = comp->cq;
         attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
         attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
-       attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX;
+       factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
+                                  ISCSI_ISER_MAX_SG_TABLESIZE);
+       attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
         attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
         attr.cap.max_recv_sge = 1;
         attr.sq_sig_type = IB_SIGNAL_REQ_WR;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h 
b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296ba..c9ccf1d 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -63,7 +63,8 @@
                 (ISER_RX_PAYLOAD_SIZE + sizeof(u64) + sizeof(struct 
ib_sge) + \
                  sizeof(struct ib_cqe) + sizeof(bool)))

-#define ISCSI_ISER_SG_TABLESIZE                256
+/* Maximum support is 16MB I/O size */
+#define ISCSI_ISER_MAX_SG_TABLESIZE    4096

  enum isert_desc_type {
         ISCSI_TX_CONTROL,


On 7/7/2020 3:36 PM, Krishnamraju Eraparaju wrote:
> Looks like the commit 07173c3e(block: enable multipage bvecs) has
> uncovered iSER SQ sizing issue.
>
> Here is how I hit the issue:
> Created two luns under single target, then run the below script on each
> lun(parallelly).
>
>    while [ 1 ]
>    do
>    iozone -i 0 -i 1 -I -+d -s 100000 -r 16384 -w
>    done
>
>
> Then failures like below are logged in dmesg output, due to iw_cxgb4 SQ
> getting full at iSER target.
>     "isert: isert_rdma_rw_ctx_post: Cmd: 00000000cb75342a failed to post
> RDMA res"
>
>
> This issue won't occur if luns are created on seperate targets.
> Also, the issue won't occur if I revert the multipage bvecs(07173c3e)
> changes at initator.
>
>
> Currently SQ is being sized this way:
> attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS:138 +1 +
> (ISCSI_DEF_XMIT_CMDS_MAX:128 * factor:3) = 523.
> I tried increaseing the SQ size and observed that the issue is not
> occuring when attr.cap.max_send_wr is 562.
>
>
> Looks like the avg length of RDMA READ/WRITE operations has increased
> after "multipage bvecs" changes.
> Queueing many large sized RDMA READ/WRITE WRs may cause backpressure and
> increases the chances of SQ getting full at provider driver.
> Notice the length(0x7f000 & 0x2000) of each RDMA READ operation below,
> for Before and After case.
>
> Before "multipage bvecs" RDMA READ:
> [  +0.001903] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x78]
> [  +0.000007] iser: iser_fast_reg_mr: lkey=0x8a41 rkey=0x8a41
> addr=0x446166000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:120 READ tags
> RKEY:0X8A41 VA:0X446166000
> [  +0.000007] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x6f]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x13b51 rkey=0x13b51
> addr=0x443b25000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:111 READ tags
> RKEY:0X13B51 VA:0X443B25000
> [  +0.000022] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0xe]
> [  +0.000001] iser: iser_fast_reg_mr: lkey=0xa371 rkey=0xa371
> addr=0x4461a4000 length=0x2000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:14 READ tags
> RKEY:0XA371 VA:0X4461A4000
> [  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x79]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x12f4f rkey=0x12f4f
> addr=0x4461a9000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:121 READ tags
> RKEY:0X12F4F VA:0X4461A9000
> [  +0.000005] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7d]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0xe040 rkey=0xe040
> addr=0x447e67000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:125 READ tags
> RKEY:0XE040 VA:0X447E67000
> [  +0.000021] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7b]
> [  +0.000001] iser: iser_fast_reg_mr: lkey=0xb149 rkey=0xb149
> addr=0x3d0366000 length=0x2000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:123 READ tags
> RKEY:0XB149 VA:0X3D0366000
> [  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0xb]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x1014c rkey=0x1014c
> addr=0x3d0368000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:11 READ tags
> RKEY:0X1014C VA:0X3D0368000
> [  +0.000007] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x62]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x7c3b rkey=0x7c3b
> addr=0x3d03e7000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:98 READ tags
> RKEY:0X7C3B VA:0X3D03E7000
> [  +0.000021] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x11]
> [  +0.000001] iser: iser_fast_reg_mr: lkey=0x11752 rkey=0x11752
> addr=0x3d6de6000 length=0x2000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:17 READ tags
> RKEY:0X11752 VA:0X3D6DE6000
> [  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x77]
>
>
> After "multipage bvecs" RDMA READ:
> [  +0.002455] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7d]
> [  +0.000006] iser: iser_fast_reg_mr: lkey=0x7991 rkey=0x7991
> addr=0x3d2819000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:125 READ tags
> RKEY:0X7991 VA:0X3D2819000
> [  +0.000005] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7e]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x8c9b rkey=0x8c9b
> addr=0x3d2898000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:126 READ tags
> RKEY:0X8C9B VA:0X3D2898000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7f]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x856d rkey=0x856d
> addr=0x3d2917000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:127 READ tags
> RKEY:0X856D VA:0X3D2917000
> [  +0.000004] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x1]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0x9b55 rkey=0x9b55
> addr=0x3d2999000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:1 READ tags
> RKEY:0X9B55 VA:0X3D2999000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x2]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0x86cf rkey=0x86cf
> addr=0x3d2018000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:2 READ tags
> RKEY:0X86CF VA:0X3D2018000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x3]
> [  +0.000003] iser: iser_fast_reg_mr: lkey=0x8062 rkey=0x8062
> addr=0x3d2097000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:3 READ tags
> RKEY:0X8062 VA:0X3D2097000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x4]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0xc34b rkey=0xc34b
> addr=0x3d2116000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:4 READ tags
> RKEY:0XC34B VA:0X3D2116000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x5]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0x8b6d rkey=0x8b6d
> addr=0x3d2195000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:5 READ tags
> RKEY:0X8B6D VA:0X3D2195000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x6]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0xce56 rkey=0xce56
> addr=0x3d0e14000 length=0x7f000
> [  +0.000000] iser: iser_prepare_read_cmd: Cmd itt:6 READ tags
> RKEY:0XCE56 VA:0X3D0E14000
> [  +0.000003] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x7]
> [  +0.000002] iser: iser_fast_reg_mr: lkey=0xba45 rkey=0xba45
> addr=0x3d0e93000 length=0x7f000
> [  +0.000001] iser: iser_prepare_read_cmd: Cmd itt:7 READ tags
> RKEY:0XBA45 VA:0X3D0E93000
> [  +0.000002] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x8]
>
> Hence, I feel iSER target SQ is undersized and needs to be sized
> properly to hold max possible entries. I might be wrong.
>
> Please take a look.
>
> Thanks,
> Krishna.
