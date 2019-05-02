Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA22122FD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBUGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 16:06:20 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:62853
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfEBUGT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 16:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAT45wG0qnqT/xuTQVvpWrvhR2loZ2pJoqUPOujw858=;
 b=s7q0QzYa1WpeY8OefonllXVYtZadmwd3HKmcUg9DMRBtiJLFg7lAjfHI3Lh3u2jY07ob715quCkZYYliZO8s1IzGbRNRSlPwxAWkSNE81boTu1i7iRCdNO1JP8Ww5Ew/vehrS0OfHT9sfSj0fo5NINa2T7O/1KCj0Md+SfxSa3s=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6381.eurprd05.prod.outlook.com (20.179.26.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 20:06:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 20:06:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/umem: Handle page combining avoidance
 correctly in ib_umem_add_sg_table()
Thread-Topic: [PATCH rdma-next] RDMA/umem: Handle page combining avoidance
 correctly in ib_umem_add_sg_table()
Thread-Index: AQHVASJ/DzlQVKSDd0SWqzyxbA436Q==
Date:   Thu, 2 May 2019 20:06:16 +0000
Message-ID: <20190502200611.GA7805@mellanox.com>
References: <20190429213204.17892-1-shiraz.saleem@intel.com>
In-Reply-To: <20190429213204.17892-1-shiraz.saleem@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec33174-2178-47cc-9f92-08d6cf39a213
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6381;
x-ms-traffictypediagnostic: VI1PR05MB6381:
x-microsoft-antispam-prvs: <VI1PR05MB638115D024DAFEF0880D2A4FCF340@VI1PR05MB6381.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(102836004)(6506007)(6512007)(386003)(33656002)(52116002)(11346002)(99286004)(81166006)(476003)(2616005)(81156014)(486006)(66476007)(316002)(8936002)(76176011)(478600001)(6916009)(8676002)(186003)(26005)(446003)(66556008)(305945005)(73956011)(66446008)(64756008)(66946007)(54906003)(1076003)(6486002)(3846002)(2906002)(6246003)(36756003)(7736002)(4326008)(25786009)(6116002)(86362001)(6436002)(71190400001)(66066001)(71200400001)(68736007)(14454004)(256004)(14444005)(229853002)(53936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6381;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fyGuYk6yxFD5XyeyH3JuFbIQY4wE8mEFjLMyWQu4yWaFz3ulnYMp9P5bW3dwhP63ywOFO5jOMm5fWKDn+DQc5gGuuhDYp/iEZXrjJe4d9OzLe5bleFhR7tbdbEswQopNdOxNaJcj3EF+B8A8yY56iOoNlmzs23UrjZO9zVsicjYHrWemn8ivjUzuWqlj08e6q7nPFa3i9p/NXexBXPfV2L9ZSjSP//rEJ9+yEGTBKmhLJC5V0XBFHwIf7pOEs+k/75EmO8j3s93EqYPGSx/8JccgXae1BNJNECkGhYyjM4B0B1QZWsD/qtZIVkWKKH2cPjCThPK2UwXYk7raoQiXwuesZb0muPzfnq3dS6N8IeqmyVquibggkbxo0zNYhazNyjXhGGBs7OMQah4txWqwKIcjNtNHlrD7LAKKXrCczg0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B83DC788F088974AB0A804CEB52088B1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec33174-2178-47cc-9f92-08d6cf39a213
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 20:06:16.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6381
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 04:32:04PM -0500, Shiraz Saleem wrote:
> The flag update_cur_sg tracks whether contiguous pages
> from a new set of page_list pages can be merged into the
> SGE passed into ib_umem_add_sg_table(). If this flag is true,
> but the total segment length exceeds the max_seg_size supported
> by HW, we avoid combining to this SGE and move to a new SGE (x)
> and merge 'len' pages to it. However, if i < npages, the next
> iteration can incorrectly merge 'len' contiguous pages into x
> instead of into a new SGE since update_cur_sg is still true.
>=20
> Reset update_cur_sg to false always after the check to merge
> pages into the first SGE passed in to ib_umem_add_sg_table().
> Also, prevent a new SGE's segment length from ever exceeding
> HW max_seg_sz.
>=20
> There is a crash on hfi1 as result of this where-in max_seg_sz is
> defaulting to 64K. Due to above bug, unfolding SGE's in __ib_umem_release
> points to a bad page ptr.
>=20
> [ 6146.398661] TEST comp-wfr.perfnative.STL-22166-WDT _ perftest native 2=
-Write_4097QP_4MB STARTING at 1555387093
> [ 6893.954261] BUG: Bad page state in process ib_write_bw  pfn:7ebca0
> [ 6893.961996] page:ffffcd675faf2800 count:0 mapcount:1 mapping:000000000=
0000000 index:0x1
> [ 6893.971565] flags: 0x17ffffc0000000()
> [ 6893.976257] raw: 0017ffffc0000000 dead000000000100 dead000000000200 00=
00000000000000
> [ 6893.985518] raw: 0000000000000001 0000000000000000 0000000000000000 00=
00000000000000
> [ 6893.994768] page dumped because: nonzero mapcount
> [ 6894.084904] CPU: 18 PID: 15853 Comm: ib_write_bw Tainted: G    B      =
       5.1.0-rc4 #1
> [ 6894.094644] Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS SE=
5C610.86B.01.01.0014.121820151719 12/18/2015
> [ 6894.106816] Call Trace:
> [ 6894.110155]  dump_stack+0x5a/0x73
> [ 6894.114447]  bad_page+0xf5/0x10f
> [ 6894.118640]  free_pcppages_bulk+0x62c/0x680
> [ 6894.123904]  free_unref_page+0x54/0x70
> [ 6894.128692]  __ib_umem_release+0x148/0x1a0 [ib_uverbs]
> [ 6894.135028]  ib_umem_release+0x22/0x80 [ib_uverbs]
> [ 6894.141003]  rvt_dereg_mr+0x67/0xb0 [rdmavt]
> [ 6894.146382]  ib_dereg_mr_user+0x37/0x60 [ib_core]
> [ 6894.152235]  destroy_hw_idr_uobject+0x1c/0x50 [ib_uverbs]
> [ 6894.158868]  uverbs_destroy_uobject+0x2e/0x180 [ib_uverbs]
> [ 6894.165611]  uobj_destroy+0x4d/0x60 [ib_uverbs]
> [ 6894.171277]  __uobj_get_destroy+0x33/0x50 [ib_uverbs]
> [ 6894.177547]  __uobj_perform_destroy+0xa/0x30 [ib_uverbs]
> [ 6894.184094]  ib_uverbs_dereg_mr+0x66/0x90 [ib_uverbs]
> [ 6894.190337]  ib_uverbs_write+0x3e1/0x500 [ib_uverbs]
> [ 6894.196473]  vfs_write+0xad/0x1b0
> [ 6894.200762]  ksys_write+0x5a/0xd0
> [ 6894.205069]  do_syscall_64+0x5b/0x180
> [ 6894.209728]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in =
SGEs")
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/core/umem.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
