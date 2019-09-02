Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731B2A5067
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfIBHxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 03:53:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:10568 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729457AbfIBHxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 03:53:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x827npsx015734
        for <linux-rdma@vger.kernel.org>; Mon, 2 Sep 2019 00:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tAULmEGCExiXXcA8F0pGuIIYOussm/3bNqakFMsWHTA=;
 b=umqD35AT0g7V2YU6DeWwmhrjZJE0tgL4zWY/6WyXs5Rp1nM/CTj1ldQyaZm0CjDltYVY
 rBIFpe06DpiJdxc4mYHUsdpM0sIQAiPFf9PwwXJCHSkoeBW1639d3wSxwDLGu7f4emjs
 d+7LqruE/qP24eEWU9QAKHTasH4gZ+5RJaVo3Zxt4OEcNhitfJJ0DQ2mkF3ShHt39ewr
 nM1UdMqmtrpWiiZ7pEroZU5ikZLWlczwG30ChntT2X+/8/bfn+UMJpVhomXJbLOwonr+
 ndFPCuVvABOXvvU6n0pAaf4lkg8tR+RetSWEoTi77KPM2fBHrThu9XTnARRu6b53otnB oA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm5ams-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 02 Sep 2019 00:53:36 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 00:53:34 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 00:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUhVqoelgQ3EfIOrJQRi+AUNNAf/JVYFKSnLBdukS9mZbs/yxIThn/WovxcyZ+3Kb4aT9Z63pamEUgHJDqXWs1PZDiuo1ywzfb2SBBdAOek0E6vIy5WeTyb91bmEkyPB/qLZ8C+X2NxifTZumA1nXJUFTpUajD84FJu8dmWQpuYaBAwFxy2+LKGqRoioOL3XomBEcNmWGT9uR20VFsnOS9tPMlyA5kKa5c/RHpud8BqIU7E+dtFg/YK36uXPyh0Y2FQbiBE14UHZevbAGFmBt+CePozcsMqI4EcbrwFsiSIAesGZQZT0GaPggDwS3StsF+3E0th5lhBo5h3XlieK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAULmEGCExiXXcA8F0pGuIIYOussm/3bNqakFMsWHTA=;
 b=KM2d0ubwMA/F79gpv9KfgckjLsoncS8bRSyB0y/j3iQWhaO0cJAN0bKXaxm+AhpGGcfVByILgR9l4Gkf6dcKgRag7QdjJlgmq0mtTVG5qNaCYBXTHwTXPEjfZ/hFmCeFbvOJx2uYAki1aPA1IWSS2x+UmVbpE+uiJk7F2cG3R0uYkzGiZ9SB92um952CyqMBjh9huVrEK9va4OGeDEv8rdx/gAZhX0/DC5QUl8s2oXQCT2Qn3xYwsx6hbd14wU2KU0ewh+as1OfFy/4x2CaqZDsNrvML6JdSY4oeVZP3sGxt1tH6nX2uPcEWZcNvWvpz1HKNZe5vhPV+cSqqjrox6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAULmEGCExiXXcA8F0pGuIIYOussm/3bNqakFMsWHTA=;
 b=vn3INkU0tALvRMBeBCllEqCppQWW3Hki9Zfgh8Rb3obMQwBS+lvjtJDAS1U01DMCeir1seqkuBdOHu9Vp1frM3fca8Q5T3kvNKpSiCzaAu87o+GDmU5acZ7sgOsdet470jy9VfTxFXNBCs7ouP378HJFGSSzECrOSB3Poo9GtvY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2640.namprd18.prod.outlook.com (20.179.81.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 07:53:32 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 07:53:32 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: qedr memory leak report
Thread-Topic: [EXT] Re: qedr memory leak report
Thread-Index: AQHVX2DvoXeiSJn6HkmzxE71NT3G+qcYB+gw
Date:   Mon, 2 Sep 2019 07:53:31 +0000
Message-ID: <MN2PR18MB3182C84B8B623A8AE9A7FCBEA1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
 <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
In-Reply-To: <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e01348c6-3936-40f0-b0c8-08d72f7aa672
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2640;
x-ms-traffictypediagnostic: MN2PR18MB2640:
x-microsoft-antispam-prvs: <MN2PR18MB264016E8A631247E42142F87A1BE0@MN2PR18MB2640.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(396003)(39850400004)(366004)(346002)(136003)(43544003)(199004)(189003)(486006)(476003)(6116002)(3846002)(66066001)(2906002)(74316002)(305945005)(7736002)(66476007)(66556008)(64756008)(66446008)(5660300002)(66946007)(76116006)(86362001)(8936002)(256004)(229853002)(71200400001)(71190400001)(110136005)(25786009)(9686003)(99286004)(186003)(6436002)(76176011)(6506007)(14454004)(81166006)(81156014)(8676002)(53936002)(446003)(11346002)(6246003)(26005)(102836004)(478600001)(4326008)(33656002)(316002)(7696005)(53546011)(52536014)(55016002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2640;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vCAUsRdxjVIfKnmCK2MwOOv4j02zQAWVjbxH2TTfaDAHWFzJlv4LhLO6U5h4M244ZhGv/HNkxCyNn+o/svawd2CZ0gXd0kpVBGQHmCXOPIDiCZO5HtabOfEA0c8EePQg9m37xiTrLeirEKGnidSc6cFrS4235b08dstwYXwL1CFJ2PddnG4M+/IMo+m3JYcQd8mzz2fCAjCd1ZbC3Rfp09IxOy8XH9Qv//pAHksxcHiYM7bOpKCNf+AsmmIYV3AVKzMYh57nEKl0ne7NrF6Z76fTGL27gyd53HKn07d7aPW1n90zYpviUcBiGWTxC8rTSJK5rT5qRjOZWDL8CInrAtj/BiS6PuEKvsKJED5u3I/xmr1QfNkeM6izcQmEKEpqsatZfw0emS37TINhEMZHEJpsY+oR7Sc4yooCxJMRPEA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e01348c6-3936-40f0-b0c8-08d72f7aa672
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 07:53:31.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8i8pSPuTjILeMA5FoG5NnXJcUZgCCPYw1cUPuMoMhDgu50K77ruqkNn6UmNcIyggCtLfUZ1Smybs+FchiCvdmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2640
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_02:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Chuck Lever <chuck.lever@oracle.com>
> Sent: Friday, August 30, 2019 9:28 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>=20
> > On Aug 30, 2019, at 2:03 PM, Chuck Lever <chuck.lever@oracle.com>
> wrote:
> >
> > Hi Michal-
> >
> > In the middle of some other testing, I got this kmemleak report while
> > testing with FastLinq cards in iWARP mode:
> >
> > unreferenced object 0xffff888458923340 (size 32):
> >  comm "mount.nfs", pid 2294, jiffies 4298338848 (age 1144.337s)  hex
> > dump (first 32 bytes):
> >    20 1d 69 63 88 88 ff ff 20 1d 69 63 88 88 ff ff   .ic.... .ic....
> >    00 60 7a 69 84 88 ff ff 00 60 82 f9 00 00 00 00  .`zi.....`......
> >  backtrace:
> >    [<000000000df5bfed>] __kmalloc+0x128/0x176
> >    [<0000000020724641>] qedr_alloc_pbl_tbl.constprop.44+0x3c/0x121
> [qedr]
> >    [<00000000a361c591>] init_mr_info.constprop.41+0xaf/0x21f [qedr]
> >    [<00000000e8049714>] qedr_alloc_mr+0x95/0x2c1 [qedr]
> >    [<000000000e6102bc>] ib_alloc_mr_user+0x31/0x96 [ib_core]
> >    [<00000000d254a9fb>] frwr_init_mr+0x23/0x121 [rpcrdma]
> >    [<00000000a0364e35>] rpcrdma_mrs_create+0x45/0xea [rpcrdma]
> >    [<00000000fd6bf282>] rpcrdma_buffer_create+0x9e/0x1c9 [rpcrdma]
> >    [<00000000be3a1eba>] xprt_setup_rdma+0x109/0x279 [rpcrdma]
> >    [<00000000b736b88f>] xprt_create_transport+0x39/0x19a [sunrpc]
> >    [<000000001024e4dc>] rpc_create+0x118/0x1ab [sunrpc]
> >    [<00000000cca43a49>] nfs_create_rpc_client+0xf8/0x15f [nfs]
> >    [<00000000073c962c>] nfs_init_client+0x1a/0x3b [nfs]
> >    [<00000000b03964c4>] nfs_init_server+0xc1/0x212 [nfs]
> >    [<000000001c71f609>] nfs_create_server+0x74/0x1a4 [nfs]
> >    [<000000004dc919a1>] nfs3_create_server+0xb/0x25 [nfsv3]
> >
> > It's repeated many times.
> >
> > The workload was an unremarkable software build and regression test
> > suite on an NFSv3 mount with RDMA.
>=20
> Also seeing one of these per NFS mount:
>=20
> unreferenced object 0xffff888869f39b40 (size 64):
>   comm "kworker/u28:0", pid 17569, jiffies 4299267916 (age 1592.907s)
>   hex dump (first 32 bytes):
>     00 80 53 6d 88 88 ff ff 00 00 00 00 00 00 00 00  ..Sm............
>     00 48 e2 66 84 88 ff ff 00 00 00 00 00 00 00 00  .H.f............
>   backtrace:
>     [<0000000063e652dd>] kmem_cache_alloc_trace+0xed/0x133
>     [<0000000083b1e912>] qedr_iw_connect+0xf9/0x3c8 [qedr]
>     [<00000000553be951>] iw_cm_connect+0xd0/0x157 [iw_cm]
>     [<00000000b086730c>] rdma_connect+0x54e/0x5b0 [rdma_cm]
>     [<00000000d8af3cf2>] rpcrdma_ep_connect+0x22b/0x360 [rpcrdma]
>     [<000000006a413c8d>] xprt_rdma_connect_worker+0x24/0x88 [rpcrdma]
>     [<000000001c5b049a>] process_one_work+0x196/0x2c6
>     [<000000007e3403ba>] worker_thread+0x1ad/0x261
>     [<000000001daaa973>] kthread+0xf4/0xf9
>     [<0000000014987b31>] ret_from_fork+0x24/0x30
>=20
> Looks like this one is not being freed:
>=20
> 514         ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> 515         if (!ep)
> 516                 return -ENOMEM;
>=20
>=20
Thanks Chuck! I'll take care of this. Is there an easy repro for getting th=
e leak ?=20
Thanks,
Michal

> --
> Chuck Lever
>=20
>=20

