Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F148115A283
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBLH7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:59:25 -0500
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:51040
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728250AbgBLH7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BswfVp4rwaX3VWotJ/AFMz1LMGjdx137GkyIFcEq3cpH62upr3J41j8lqoA2j1tMuExno12kemMd84bZm8E8vMOn0PDne4KeqMBkrOTHp7YVv0HntohDdkbs0BbDeOK+gecglTNgYNxAdjovlaA5LdSPJ3i4LvBuDe40s0NII1dXMa7GaUrN6vk33SRJDZMoLwPXEXy+zrHSsL4GCQO/NE5DKTFUBSkceIV2Ib1bl7FG0GluH0RdNt20wN+UthLO4pCvPCTpItB/7AB8LCD8ZKRS30/M2Z9Rg5iIoGkXiuAwnzsCfqSq+Ctorzw6QEpptnq+QrhmKyWo5hloWvp+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1xWxN+O4jSUVbOjud6TdVAJ6tBTk8r+rFBWx4V4Vw=;
 b=h9nFNTGdA2tycNvcjp5R/VyyDOm6vlTclrV4rXYEELz7PsQtDq4hdg46qOdeTjh1aYtxQXVfZK1ueM22y6bmIl0RlTffXfbrop6cOTLkcEzbcEjclJZNKRJPWOPoEldAT47ygF0xeAyFxLnxt9/KmH4midp4huyr326pOD/aV8JQwyM04UweKbr+mrM9IecIbq/EW621HlwQl+kbbtJrf7W87Yz79Sp8rmhwXrtdr4FBsT8WZS5BYOWXornTlw2EO6egjx+SgHI/Eac0wROfOmirtKQZoBaDKu+acKZu3JKTzdaZ9HIkKCi8eZVTNOJdjH5ZnDcZ0+dgUmRAln1m7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1xWxN+O4jSUVbOjud6TdVAJ6tBTk8r+rFBWx4V4Vw=;
 b=MQLHOurnucjjh6AZPy4qZPh5k8CFRpalWqOjYixXPKCOUmwa/CTzRI9ZyiFWU5Pq9rDFG1QnVa0kmXlRUm51Rhtt6dWLFY9maCs6FHJTGMp8LPfVrYb5EegLstVyIkCZaICw5s82hI7iCpCjxPFF/ypPA0rHq6SGN6teNA7so7M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5045.eurprd05.prod.outlook.com (20.177.36.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 07:59:17 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 07:59:17 +0000
Date:   Wed, 12 Feb 2020 10:01:27 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 2/9] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Message-ID: <20200212080127.GA679970@unreal>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072635.682689-3-leon@kernel.org>
X-ClientProxiedBy: AM0PR05CA0064.eurprd05.prod.outlook.com
 (2603:10a6:208:be::41) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
Received: from localhost (2a00:a040:183:2d::2a5) by AM0PR05CA0064.eurprd05.prod.outlook.com (2603:10a6:208:be::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Wed, 12 Feb 2020 07:59:16 +0000
X-Originating-IP: [2a00:a040:183:2d::2a5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af0050e9-e314-4939-2eda-08d7af917543
X-MS-TrafficTypeDiagnostic: AM6PR05MB5045:|AM6PR05MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB50459FE2E97889CBC9288176B01B0@AM6PR05MB5045.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(186003)(6496006)(16526019)(478600001)(86362001)(54906003)(110136005)(33656002)(6666004)(6636002)(52116002)(4326008)(316002)(5660300002)(6486002)(1076003)(2906002)(81156014)(81166006)(66946007)(107886003)(66476007)(8936002)(8676002)(66556008)(9686003)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5045;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/426lAtIDqZIRNZ1mv52c/GBXDlQd96MO3Mu3s3uQ0Vw0vcvH5gxmaxlepqWpjct+K97FKz9Mv1B7ak/O74Q9/kUr5Axh2hmNrFUjklCc6jhbthhQMffcGg4KWfiI8POaLc/qGSDVoVV9vmYFminz4g8VIK9/LfAX/aSsl6VOaXjOXD1lqNzoVIrVS2T87DC1NMzVb1jP5uKQwRkxRXnltiZymTUPvjtOA7q8G5Z5Bw5Soh5JZDuzNqAyLtmMUeLPhRArjRuG/gu/PesrmqpL4OlYhg9m+nNQT97mjFy4+Z48Tfbaz1od4Ey3eYIXMcoXz9c/qDRpRXiWbL0NxHvDpTe8JK+n9urTOxsSTxH44eqPFhKqfPLULywme56fgYlGHbysssW+8VnvM5lS94B7PAiM2XySjHzqmVmvRxAzuaiUxth8G7jb/YT8DEcOTJ
X-MS-Exchange-AntiSpam-MessageData: sz10+yKE6P/u+KpeF76+CqhkZB4LWXvoxEqyEfTsHyd7sfzZgoz/kdSeGlJujdLQ2Y6E2z1LWQpxQz6V5FFkEfAeXujX4l7kn2kJ1BwcsbK4Ab4DZ65T5z8x8BH8lpYCpQ7EVFIsrSycuBNSAX/si5X8J6OhO23keL6twD0A3nQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0050e9-e314-4939-2eda-08d7af917543
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 07:59:17.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74XvHvhEYdn6/om9sqiCbITT28PT0QzbfqlMOh5Dc4A5V9x7alYvNI7QdNtE03z/9EvNiH12aZGpHqiDBIQqMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:26:28AM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
>
> We don't need to set pkey as valid in case that user set only one of
> pkey index or port number, otherwise it will be resulted in NULL
> pointer dereference while accessing to uninitialized pkey list.
> The following crash from Syzkaller revealed it.
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 14753 Comm: syz-executor.2 Not tainted 5.5.0-rc5 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:get_pkey_idx_qp_list+0x161/0x2d0
> Code: 01 00 00 49 8b 5e 20 4c 39 e3 0f 84 b9 00 00 00 e8 e4 42 6e fe 48
> 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04
> 02 84 c0 74 08 3c 01 0f 8e d0 00 00 00 48 8d 7d 04 48 b8
> RSP: 0018:ffffc9000bc6f950 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82c8bdec
> RDX: 0000000000000002 RSI: ffffc900030a8000 RDI: 0000000000000010
> RBP: ffff888112c8ce80 R08: 0000000000000004 R09: fffff5200178df1f
> R10: 0000000000000001 R11: fffff5200178df1f R12: ffff888115dc4430
> R13: ffff888115da8498 R14: ffff888115dc4410 R15: ffff888115da8000
> FS:  00007f20777de700(0000) GS:ffff88811b100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f721000 CR3: 00000001173ca002 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  port_pkey_list_insert+0xd7/0x7c0
>  ib_security_modify_qp+0x6fa/0xfc0
>  _ib_modify_qp+0x8c4/0xbf0
>  modify_qp+0x10da/0x16d0
>  ib_uverbs_modify_qp+0x9a/0x100
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  vfs_write+0x168/0x4a0
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: d291f1a65232 ("IB/core: Enforce PKey security on QPs")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index 6eb6d2717ca5..5c8bf8ffb08c 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -339,22 +339,16 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
>  	if (!new_pps)
>  		return NULL;
>
> -	if (qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) {
> -		if (!qp_pps) {
> -			new_pps->main.port_num = qp_attr->port_num;
> -			new_pps->main.pkey_index = qp_attr->pkey_index;
> -		} else {
> -			new_pps->main.port_num = (qp_attr_mask & IB_QP_PORT) ?
> -						  qp_attr->port_num :
> -						  qp_pps->main.port_num;
> -
> -			new_pps->main.pkey_index =
> -					(qp_attr_mask & IB_QP_PKEY_INDEX) ?
> -					 qp_attr->pkey_index :
> -					 qp_pps->main.pkey_index;
> -		}
> +	if (qp_attr_mask & IB_QP_PORT)
> +		new_pps->main.port_num =
> +			(qp_pps) ? qp_pps->main.port_num : qp_attr->port_num;
> +	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> +		new_pps->main.pkey_index = (qp_pps) ? qp_pps->main.pkey_index :
> +						      qp_attr->pkey_index;
> +	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
>  		new_pps->main.state = IB_PORT_PKEY_VALID;
> -	} else if (qp_pps) {
> +
> +	if (!(qp_attr_mask & IB_QP_PKEY_INDEX & IB_QP_PORT) && qp_pps) {
                                              ^^
Sorry, this is rebase error, I'll send another version of this patch now.

>  		new_pps->main.port_num = qp_pps->main.port_num;
>  		new_pps->main.pkey_index = qp_pps->main.pkey_index;
>  		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> --
> 2.24.1
>
