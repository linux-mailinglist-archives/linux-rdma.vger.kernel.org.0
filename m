Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED02616138
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 11:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKBKtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKBKtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 06:49:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6710222B3;
        Wed,  2 Nov 2022 03:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU+snbbMZ4iJtFuX432RU+LIgQWwKb1VYODou8DWnk3k9dpYGeSqb8ShsLBAlaJlD1eoPEf0jLQFFc8ArZ33BRUYgkC9KvAowkE2qDtkz6I6vBAy4g696v8mZs9i4UgEOx9XqhXWj2dk17gDdtkNDHlqBS+IKPr0CSABm/Ebbz0GgYYzDWfwr5Z+SbLMPMlP3Km5m/A2dnr2ZMYaixLDwNlomyLtVDWpery8STssHAbU18adDS3iLEIj98fGuv4KcidufR1JfQwzVThSvXi0e5wzg0x7aLR0wCouRYl5zGZmmF9JcrcEn7TRyV1cC0V8RIPL2GtAeaYInvP/Zb5nGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSML6Kl5Iq0ZJ05+PGB1MwEVg/KF1W8GWdKf2HmUarc=;
 b=ED5bp1D7l2wfE39iO1nRjyyWiRukhVPVxAiIX8MdPEmn5IP699cT/Iv+OzN+ayheQAJ7ltBgTja7gm0pWPtF6q5w+0Krj+/nbjebLVHEGOS2fAlhGZ3YBo0w/m4qTl+9rRGtuueHel4pxRjY/HDIiXmDQThwpTZ7oMAUBjYrT0RN3s/u45Ceiw+fSbnReV6n0VO0NRQuZcfnIPe0iT2/6P/mueA69MoZKrw7J6ZnpCNKszNRgjztVzo7iqtgN3otQ3Ng7R72XyM9Er82qhCjHkL/53SJ88Yz5tTPWOsRy7VLgioDhydICBfwM9qvVVRVz/g4dK4fna3PI0ranxIu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toganetworks.com; dmarc=pass action=none
 header.from=toganetworks.com; dkim=pass header.d=toganetworks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=TogaNetworksLtd.onmicrosoft.com;
 s=selector2-TogaNetworksLtd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSML6Kl5Iq0ZJ05+PGB1MwEVg/KF1W8GWdKf2HmUarc=;
 b=wsYQH1sWdUTGoiC049o1cyutUgZmzTgjVP1oV5jikw85M7tQkwXAkuCSOGNfhwR9QvZPdfXbkcMPaIfBtoSvjJIBPFuHC1zUFH1iAH80wAyB6EImOtFc7vNzsAQky8on4kaVC0XLbNdoxVwbXuaifnjL9rvWBQLpX1ZND5aR158=
Received: from VI1PR02MB6237.eurprd02.prod.outlook.com (2603:10a6:800:17e::7)
 by AS8PR02MB7319.eurprd02.prod.outlook.com (2603:10a6:20b:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 10:49:26 +0000
Received: from VI1PR02MB6237.eurprd02.prod.outlook.com
 ([fe80::b8a7:7177:555f:150b]) by VI1PR02MB6237.eurprd02.prod.outlook.com
 ([fe80::b8a7:7177:555f:150b%4]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 10:49:26 +0000
From:   Leonid Ravich <leonid.ravich@toganetworks.com>
To:     "linux-trace-kernel@vger.kernel.org" 
        <IMCEAMAILTO-linux-trace-kernel+40vger+2Ekernel+2Eorg@eurprd02.prod.outlook.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yigal Korman <yigal.korman@toganetworks.com>
Subject: BUG:  ib_mad ftrace event unsupported migration
Thread-Topic: BUG:  ib_mad ftrace event unsupported migration
Thread-Index: AQHY7qUIEmC+0HXRl0GAS6BMUX6rtg==
Date:   Wed, 2 Nov 2022 10:49:26 +0000
Message-ID: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toganetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6237:EE_|AS8PR02MB7319:EE_
x-ms-office365-filtering-correlation-id: a56a0f3c-6205-4a8e-a67f-08dabcbfe967
x-ld-processed: 73f7e7df-ca98-4f08-bf85-f137b447da96,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQzuLNWVaqbRDBaumhSAqURgnsQnUxQW+NUXHKDBZvWSacRtdoF7/W/vGr35Tv5ILHrCDBnsMrYQZL8J+nWHPFFucOYNQ56aQJmKy9H5dq928kVSxmTrkc2pY3aIQfvGdiAlftTlKHx7vgfL2H5NleGYK07O5dvRxCK/m2cjhozIDPpam0JfWt93l63lk+sSy0dnrwIRslyF3gdy1Q3lfukY/L4hxt2fLKQVE50KAUwBDEHTnPWbfa5TdxelbPMqSfrbs4LyFRzT+ykcN7EoODNbcJI3czrcotiugQ5aV8M7VfaU9p93zqUh26vKLirmc3mVLs02qeUiwaDINFgyCtfoo+J52LWgYzHIAM5aH+ZWgBUqOPbtSYEr5Aa+ZsoOtKZt/SYO3LLtnYjWnAq8RE6Ri4EMQH9MxVVdsc0z0nPZcXDN8niMBOtiwTgbNe/mkOgShyLw+Nuzw6fGWP/a5QAKT/3fUuceFZ6O3tnz7cdrC6ZgW7UVIOitxJlIQoJvSklbE5QBwBmbnfLWHtbrBJNLawpj+Rf7N+WW5+6a1YJ0PUaj3aDFPWdyHedqLz1W6c+iAGW16mNs4udz7t/ZfagJGaHrPYLYwSXGvh/S2Btc52NZZXQ+AstXqCeQwSlZoeTfTMBEMnRdw6MKQUMLGMLj9jthJ76lQyJ3mvsRXsemn0CE8t9VJGGMUIcwePU8l740ockmnXasrvnDUY5+PylzyD9Hpx6S2MSr9RnbIxsvI/6Ce4+ewUtiUGnPNkKE0VyXDLCmYZjelKrnxTVDGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6237.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39850400004)(136003)(376002)(396003)(346002)(451199015)(71200400001)(55016003)(38100700002)(5660300002)(2906002)(122000001)(86362001)(83380400001)(26005)(38070700005)(33656002)(9686003)(107886003)(186003)(478600001)(316002)(91956017)(66476007)(110136005)(41300700001)(6506007)(7696005)(52536014)(8676002)(64756008)(8936002)(44832011)(66946007)(66446008)(4326008)(66556008)(76116006)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K8Jb7k+zcYWrCstIB/XTBgLeUA4UAh1sXf/t9lqkJ0P07Rp8Qx3WG3DS3P?=
 =?iso-8859-1?Q?+gESP022cUIhpxcnnPAH4C5+DWQiKybr7xCYgli1X9p+Thsj8cmJ6FPlit?=
 =?iso-8859-1?Q?IjRxl3nYYEzVNWfD8sX/kB4FkBpN5IExkK6KKft70UFERPZF8dvJO/8iK6?=
 =?iso-8859-1?Q?oXGFLTAarkd8bDV+SE4tDNomMBq8MGmmVITTyKKtR130Wyg5iPcAUGY8nB?=
 =?iso-8859-1?Q?8rUuUU8QcL6Dk/LifDzclnoA+qXEQuWl5GyYdcI+DmOXsYxXpUltXepGYX?=
 =?iso-8859-1?Q?7kJxmN8/S+Cc9CESL2X7Wt3Gd4QGBS3x/7nGgpATO5QMyRSsxc1ZJ9idZf?=
 =?iso-8859-1?Q?un08H1dfbd7Nd/Kad69ge1y5vCNkY1Q+9O4zyf1Cslt2SJ3u48Nv65Uke6?=
 =?iso-8859-1?Q?ik3RXfVdGJzkVFnwJyxfK+gkQ9Pd2dERPJlawp0jVJDxQIo/paUmSLE7y8?=
 =?iso-8859-1?Q?jBF0Dwm3bmWJtfLkc3Sw0aJ5XwW4Jxrh96UPGTTlGhcMgQWNjHzlWkFGUL?=
 =?iso-8859-1?Q?fZ9bH7CujmqotbjNSiVUxaRAlqDM99WerCfrWhEJ0TowG47DeQlfEaMlC6?=
 =?iso-8859-1?Q?LpF6X5yCi1iaduQto3qMGSgLOgj8JyJuGkR98sOBC86KVMUDXd0j81KI+B?=
 =?iso-8859-1?Q?XFryRCq5hzOvW0rg1SSEuKZ2/9HuaMdeqiyAqjm9CLOFDIoLnzaoI9D9cq?=
 =?iso-8859-1?Q?frxDsEWebQqBRGXlpXVLYF30Hb4jbrDBFoS2a3tBT/wnzPYT4kfsDaRaaW?=
 =?iso-8859-1?Q?lIX1/h2NN3aoV/XzWgh5j2zqgX/Z1OGxO2+UNLmj/kHmCE9tCiDz5pRgrr?=
 =?iso-8859-1?Q?3ri2n5tqLQZOQCqOgR8+YPH0oePEBRROFrVymfscxxj5RpIs3xNK11zJI7?=
 =?iso-8859-1?Q?ysDIB+F1E6iQmkwXmsd0hEXtYeJvc5FbVP3x3/UCSR+Sbl5xEeB7JyZKL3?=
 =?iso-8859-1?Q?wyLSWCEgbM6KojOX27CiH4MXZiGuVyU9GX2zdS26AM2dRMmkK16fsg72Uu?=
 =?iso-8859-1?Q?8jD4v/R3ly7pZ/7ZV3CKyC0b05KYYTKmCK77ZQDm55SpzXJajyFL1zCylU?=
 =?iso-8859-1?Q?dxceJvCUpzWSNMTCWmzYyi3ryk46XdF6BQLPES8+ThBPLbSdA0vtvg4skZ?=
 =?iso-8859-1?Q?gl9S3ExdrQNjtLfIMlntiiq2DH48rTxq6/p2vclTuo1O5EFNdJBYMx6zv1?=
 =?iso-8859-1?Q?K1ZJYB3+Bee/bEdJ7XjaIfnwevNifGy2ViCh6apHvjHqHxWxJdLp4jziXb?=
 =?iso-8859-1?Q?/FGClwMDWz6/ID2JJMGZx5x1a5gVMd5u81YEYzqn9XaYkv6kpkQ/Evgmtx?=
 =?iso-8859-1?Q?XJUgR1gia2tGEE3GU9S8bHplJSPa9Xvb1uCyyB4QTPwjvpNzq0A+TUVrjn?=
 =?iso-8859-1?Q?USA3Lu2uc5xtlzHdvtXCLytz/Qzn6zymSk8H1HwXwCiaOh7uhPJ4sQOIds?=
 =?iso-8859-1?Q?xrSwp5jQKG9TFaA3s8wGhNig9k2jU0nXhNaSuliNAmJ4/8azP3RMUlIDhV?=
 =?iso-8859-1?Q?mPoUMPNG1+B7y9L6/YnoaQoh16B0OrRCcyVlitshMEX4qc2ZqBv6IbSsUP?=
 =?iso-8859-1?Q?brgm0ZyZg8p6hvtJD2iycTfuNpP8rn3Vrf1KohIHNbsvrI08+ZXhgmbyqo?=
 =?iso-8859-1?Q?Pekv1E5OHNs9sXlRtQ9D58sQPD+kTzPTGSbZBd6jlDdGmb0V9VqBStiA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toganetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56a0f3c-6205-4a8e-a67f-08dabcbfe967
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 10:49:26.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73f7e7df-ca98-4f08-bf85-f137b447da96
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whPnM9jd+5ybAgG9pIwZlALOE11nVhbJ/nyLYgn3d5bWDBsN7CIysVjZYKP+As9aqww2KjlOUvlXOr4eRVDXFsh2r7Tg1K7kekE83KgvWeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7319
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

after enabling ib_mad events hit this warning=A0=0A=
=0A=
echo 1 > /sys/kernel/debug/tracing/events/ib_mad/enable=0A=
=0A=
WARNING: CPU: 0 PID: 1888000 at kernel/trace/ring_buffer.c:2492 rb_commit+0=
xc1/0x220=0A=
CPU: 0 PID: 1888000 Comm: kworker/u9:0 Kdump: loaded Tainted: G =A0 =A0 =A0=
 =A0 =A0 OE =A0 =A0--------- - =A0- 4.18.0-305.3.1.el8.x86_64 #1=0A=
l: Hardware name: Red Hat KVM, BIOS 1.13.0-2.module_el8.3.0+555+a55c8938 04=
/01/2014=0A=
l: Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]=0A=
l: RIP: 0010:rb_commit+0xc1/0x220=0A=
l: Code: 00 00 80 fa 1f 0f 84 ec 00 00 00 48 01 87 b8 00 00 00 48 8b 87 98 =
00 00 00 48 85 c0 0f 85 72 ff ff ff 48 8b 47 08 f0 ff 40 08 <0f> 0b c3 48 8=
b 00 48 89 87 b8 00 00 00 e9 48 ff ff ff 48 8b 47 48=0A=
l: RSP: 0000:ffffa8ac80f9bca0 EFLAGS: 00010202=0A=
l: RAX: ffff8951c7c01300 RBX: ffff8951c7c14a00 RCX: 0000000000000246=0A=
l: RDX: ffff8951c707c000 RSI: ffff8951c707c57c RDI: ffff8951c7c14a00=0A=
l: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000=0A=
l: R10: ffff8951c7c01300 R11: 0000000000000001 R12: 0000000000000246=0A=
l: R13: 0000000000000000 R14: ffffffff964c70c0 R15: 0000000000000000=0A=
l: FS: =A00000000000000000(0000) GS:ffff8951fbc00000(0000) knlGS:0000000000=
000000=0A=
l: CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
l: CR2: 00007f20e8f39010 CR3: 000000002ca10005 CR4: 0000000000170ef0=0A=
l: Call Trace:=0A=
l: =A0ring_buffer_unlock_commit+0x1d/0xa0=0A=
l: =A0trace_buffer_unlock_commit_regs+0x3b/0x1b0=0A=
l: =A0trace_event_buffer_commit+0x67/0x1d0=0A=
l: =A0trace_event_raw_event_ib_mad_recv_done_handler+0x11c/0x160 [ib_core]=
=0A=
l: =A0ib_mad_recv_done+0x48b/0xc10 [ib_core]=0A=
l: =A0? trace_event_raw_event_cq_poll+0x6f/0xb0 [ib_core]=0A=
l: =A0__ib_process_cq+0x91/0x1c0 [ib_core]=0A=
l: =A0ib_cq_poll_work+0x26/0x80 [ib_core]=0A=
l: =A0process_one_work+0x1a7/0x360=0A=
l: =A0? create_worker+0x1a0/0x1a0=0A=
l: =A0worker_thread+0x30/0x390=0A=
l: =A0? create_worker+0x1a0/0x1a0=0A=
l: =A0kthread+0x116/0x130=0A=
l: =A0? kthread_flush_work_fn+0x10/0x10=0A=
l: =A0ret_from_fork+0x35/0x40=0A=
l: ---[ end trace 78ba8509d3830a16 ]---=0A=
=0A=
warning originated from below code (kernel/trace/ring_buffer.c)=0A=
=0A=
rb_end_commit()=0A=
{=0A=
...=0A=
if (RB_WARN_ON(cpu_buffer,=0A=
                !local_read(&cpu_buffer->committing)))=0A=
...=0A=
}=0A=
=0A=
after investigation  looks like there is a broken assumption of rb_end_comm=
it and rb_start_commit are on same CPU (no migration) during trace =0A=
looking in ib_mad trace  in include/trace/events/ib_mad.h there is a call t=
o create_mad_addr_info during  TP assign which sleeps (at least under mlx5 =
ib driver)=0A=
=0A=
so the scenario looks :=0A=
=0A=
rb_start_commit - buffer 0xffffa0984777e400  CPU 1 pid 1368=0A=
switch from 1368 to 1605=0A=
thread 1368 () is migrating from 1 to 0=0A=
rb_end_commit - buffer 0xffffa09847c14a00  CPU 0 pid 1368=0A=
=0A=
before starting throwing some patch into the the air  I would like to align=
 with you the approach we should take here. =0A=
=0A=
my suggestion here : =0A=
- ftrace infra should verify no migration happen  (end and start happens on=
 same CPU)  in case not we will  throw warning for the issue  .=0A=
- ftrace users will be responsible to avoid migration during TP assign (RDM=
A in my case)=0A=
=0A=
please let me know what do you think =
