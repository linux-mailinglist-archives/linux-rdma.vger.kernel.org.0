Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47B4B7619
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiBOQp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 11:45:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiBOQpW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 11:45:22 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533571019FA
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 08:45:11 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FGM4Td030009;
        Tue, 15 Feb 2022 16:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=p4b3EzDGRYXhidUrGEQtmjP+kLDQRzITwfY8WBL0X1k=;
 b=CsApYud1YDFiRrBcniDi2Jy3ci0Pp/qZXKCcZhfUlURapCFe7EhlWQST1N+jJhNQvwxW
 LTDrrs7nzAlTe/J8hR7/SRwDx9WK//ii21C9Me7I3GaGuJ1nEx1z3NACZnrVjjcc0Zmi
 LqOO5Ae7Nsa/+a2s0bU9TkadedaosrAsDHtoQcD3YTy3iw53uPtoYsjXVQDXrZ7fC2nI
 /I/E8ViT/vFt/QdAhb9w1+nlNMs1edwirZ+e+fHmYQctB3lVqMiOAv838MXSrG6qOpZM
 M+1LwFTDp7/8RSew6lxo+BfZJE/aMioD45D3jrtsm1Z1/E+KR8kuGTQQyqlJdCbuSWOh og== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8fmnr7fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 16:45:04 +0000
Received: from G4W9121.americas.hpqcorp.net (g4w9121.houston.hp.com [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 842F8A7;
        Tue, 15 Feb 2022 16:45:03 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 15 Feb 2022 16:45:03 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Feb 2022 16:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZyj3a7lbKIAW1JRFxXhslotHjnvJOafcSC754RUAEVt7HwhdFRFYLHeQbDid3nA1CvX2ZneLXsPaixGB3hChJWJMKpRZ9/DdB9W2hqQd2GJz3Hqc/ygOGzL3BcEmSmiQtSFp74Grj2ZtfpBmjqVNFokZn8qXZYq79KNgHhbiqkg+MUcqADUBUV2i4kj4Qax41ud1fz0Azp7ZL0kz7jT8oJUqY13DQocOYLdiyufkVomh9XWa/N8o9yTjlNc7x/qWVXnsReriGlPeWGQtv7gVqY/ZfZRqIMArndqkDLYytG5T+9r2NZrBZIVYW1Qz46iRN0YVOQuEFPcAcG7mc+aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4b3EzDGRYXhidUrGEQtmjP+kLDQRzITwfY8WBL0X1k=;
 b=ACPuLruerJYri+p3yw80jUtNQqSjdKwnV9yUlA1z4BwiAifhDdFcHM8po5bGkHdZ4ffOGYi+Y1BocxXiL/rPbH+Dhtt/dirwvytGZtJK0nZcE5ySpkzNKn6ETdKc0DIy1P1FwIMxbTfBEHFOk+JuvTwz2AfXsxyfxtchgMJg1Up0b06Z66HK9B4g8vnsf4BQDomVMuQmeEUn6cDmmJ2Vj8K/M67UnBHZov3TRalBwlTpYfsc7Fbe75rV7SXKDt+9B8Ax+ch5MPTBZEaO7xxiWxJ6ilLEUU/K67U4MlyUD/YBxLwn0NfVh+lacYH/sAri5XYNRfuO330lv0xB8+g0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by MW5PR84MB1913.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 16:45:01 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8882:19f:abf:c173]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8882:19f:abf:c173%5]) with mapi id 15.20.4975.015; Tue, 15 Feb 2022
 16:45:01 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Inconsistent lock state warning for rxe_poll_cq()
Thread-Topic: Inconsistent lock state warning for rxe_poll_cq()
Thread-Index: AQHYIczu9oQKWqycI0OU3v8E5biivKyThZ4BgACUwACAAJZngIAAHmvw
Date:   Tue, 15 Feb 2022 16:45:01 +0000
Message-ID: <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
 <20220215144159.GQ4160@nvidia.com>
In-Reply-To: <20220215144159.GQ4160@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33c30edc-b8a6-4f93-4803-08d9f0a28292
x-ms-traffictypediagnostic: MW5PR84MB1913:EE_
x-microsoft-antispam-prvs: <MW5PR84MB19133B07EAD7E66A952B3352BC349@MW5PR84MB1913.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +orlgVq9gzLXJ3sk0gOmUx4rm9+5oc+gRqm04GB8P9oFiHVT80wwJOTGFj+G1azCEV8dzv5+TU8juIwwP6pZJkv93w59EQAOnmfpOvHHph3Hu9XY9JJYok1CGIImG+geGjFioX8rho07eP4aNvl4kUgLJ7rXlcfb90xuB0G9243FaeFIFrRlHfC5DloqzIfrTZ9R+GycLTu0YdMfZIoyUYSDl8BKYhlBYMKGopkpur0ZkWXwDeCeXPu0XZkjrOCHkUmU5cEgMfMYObsB4kCaE2D92atEwH55YpiJ+DU6SwsKyx09GD74Q8djf/OFqWaUqGVDuAlEPhml3DsB1ZnpcriRdPF0eR7pLvq7Hc/fN5l9ZEitni07zWZ85TlutTQ3Y7ogBpb6QbrElJirARn9XcAC3dArS8kD3PeuiGep9+qmpRuj3o5a0Rd77arGIhkfsLChdsKvnJ4qWoWxmFaRPsV7WbC5PWvjuVn5INB9NDJ1kaJA7QSHi1kehmfduqJx1zQ0KbILmXBl7tp/Tj69gvuSUI7FVIrC2XJR6LkfVrjr6Su3sagISjK2eC8gveUGKg+Kaz9bHucTQpxVwcfbV6BbawuYmYZO8gTXJPpceQJTzPhGt+2qg6hxYmpUrHvBl9qTNIT5vhl59IvoidYcrw6JQ24T4nhHZEV1ZXzngzTeqgXsd/RL4yWjYhzyrxeaNGHq9ZL3Ow6y0qDNZI8Efw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(8676002)(4326008)(55016003)(52536014)(71200400001)(8936002)(186003)(9686003)(53546011)(7696005)(122000001)(6506007)(86362001)(33656002)(110136005)(83380400001)(38100700002)(316002)(82960400001)(2906002)(5660300002)(76116006)(66946007)(64756008)(66476007)(66446008)(66556008)(508600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aA6GxNhf3NIegIGgGjYHw1rl4S+R4Qy3tyz8u8/HXh61LD0x41HjknX/NIzK?=
 =?us-ascii?Q?wq+y34B7Aw6XhntRHK26iRK2DaWOcmZh3ry+RvX/DKV64ftAnU6wINzSLpj/?=
 =?us-ascii?Q?FZjXbKjTJXI7HlV0tfecx4IQNcUhjjeo5O1ZqWDf692PM0l2PZtVAfHsTtq3?=
 =?us-ascii?Q?TecjUqN3LXb6vILdSUsgYD8zd2RQAOdh1+gJQvUfPiFVgcH/Ww1CuRn5v/Sm?=
 =?us-ascii?Q?MnPdDF36WaXDkT3ekdcK850LHqaHrpU72rz1srC0VI+weiWa11vzNlSxCfN0?=
 =?us-ascii?Q?H9kJVYhDPoLk131/eWLMc1kJrLD1qATdKAJChVbe3EGpdHGlHUS3MXwHI1kt?=
 =?us-ascii?Q?zlHSJBNLQb5oAJNUeI74bF5G+MiyvOczJz7Ty39lL9waXLZHttVfalLooXBG?=
 =?us-ascii?Q?3V5a0w06yjZXbpyVT9J7Hkiq0tvQsr/g/7ciG3BSsRNIvtirSzsC+s2L5a7M?=
 =?us-ascii?Q?KWx99bClbd/hc5tyla2ly38NMoSOEgYMjV6VRf1ESs+ukK2GLilVYgOO3Uve?=
 =?us-ascii?Q?KwI46CpdEuALoMnDJBXhPsnEIziQqprCb03IY9NGQGuJldk6iTJJgdRsgM82?=
 =?us-ascii?Q?QcoPmSIiveSrbIip47g3FdNZ3/QVxnpGGKag5ReUmQlLwq9b+faQogGIJu4g?=
 =?us-ascii?Q?ilZd32hmoPImml34kcrnTOhte/edh/PiLdZGmOs8GNRwffwCvgK+Pz/xq4xU?=
 =?us-ascii?Q?ScqwWb5Ix8DcnffZq3ccj1RW8UaQ+nmzJ/iIxoPVMB22dWjTPA0Jt7hI2DcZ?=
 =?us-ascii?Q?/5Fw3zJs7raCr444SiN06F0Ow8V5odf5gmXugPl+Ng8HeQ6rVDeI8gVIX1rs?=
 =?us-ascii?Q?J/2v5bt8NjD0xUHVnCig4ckL9hUFg4DXcGWs/vwoWs3DP1Nxo3y0yxQ58TPc?=
 =?us-ascii?Q?jjuNfMNr2d5+Kiyufw1xh1kN58ib2HPnLUHTvhQ4CJL06tV/sqJ5WgRf1RFn?=
 =?us-ascii?Q?GmrTlyGnlIMrscCHaYQYXoC5G6Rc4IYJKYLscMRSpV0UPRHxEImMEmMA4Jf6?=
 =?us-ascii?Q?mlC8UuUf76WSW3zk+iu7rgG10vRwpydLytGoRkY9nKA4i7nEIXCJ9O6hRoYl?=
 =?us-ascii?Q?sxiK8o+qhTMCyW94+3nWHcmKVynPNI9OR39f/k/qlgZCoFog1nTWqXqOE8QH?=
 =?us-ascii?Q?LPHznjqPsvweOz9yXpRqXsAT1FyP0QvX5YfhLtMUDAgN+Z+SN95FQ8VMfKnb?=
 =?us-ascii?Q?adICV9qgYHiy56yDY5Hn11DsHL6uXe9FmdCbTSBz9JaE68u6BGb46aCucuBg?=
 =?us-ascii?Q?xL8qUGhHs6Ue9bOFGDBcExXWdSrFVsM/b+KgqHOuGGwZuIUFe2EbgRF9u2V+?=
 =?us-ascii?Q?BorfbMYGKKlXyn4GpCxEa+HfwF24wMBdMPM2q5ypyVYGQHwPHwd265jMj49b?=
 =?us-ascii?Q?8dD4rbAwvHpaT3oZkLiNtMIEQD+yK8sn/B8r6U1WK7uPbywoeib877QMoPYC?=
 =?us-ascii?Q?zUKLEjoGtZWup5+gPos7XKz4s7G8ZBXnFF0hO19TKTl7p6jortK9gzhlobKo?=
 =?us-ascii?Q?CYMXJV5sxax9afydfN+j1XYTcZP2MnP9WDi+F252Mhi9UVcq6WiBJj66bxa+?=
 =?us-ascii?Q?c8if09LTyaJbFeEXzkP/uzx8R6IntqIWVxhMFuZUaK9iiMCXOgJa06prW0XY?=
 =?us-ascii?Q?UHFwrNc2scRS13TNF/cIUNB8F0HRxUDDqXRXMtGE8k2QhV2lOPBxm7mhiDis?=
 =?us-ascii?Q?ZEtIN6Opw5eYEZrDSdA/go7LqCQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c30edc-b8a6-4f93-4803-08d9f0a28292
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 16:45:01.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnlB6t7s0/IacZhp1IASoSNVZN7pzqm3YxpI2ClAVaeR5VuH7lHUpin6x+W2ag/kQzjGA46fujtwsr3bwSV3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1913
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 68vf-AqQnsVwDtzCs79VIUkq_U-HWJpd
X-Proofpoint-GUID: 68vf-AqQnsVwDtzCs79VIUkq_U-HWJpd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=865 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150098
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Tuesday, February 15, 2022 8:42 AM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>; Guoqing Jiang <guoqing.jiang@linu=
x.dev>; linux-rdma@vger.kernel.org
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()

On Mon, Feb 14, 2022 at 11:43:40PM -0600, Bob Pearson wrote:

>> in the write_unlock_bh() call. This appears to complain if hardirqs=20
>> are not enabled on the current cpu. This only happens if=20
>> CONFIG_PROVE_LOCKING=3Dy.

> The trace shows this context is called within a irq disabled spinlock reg=
ion. Ie this is trying to do

>   spinlock_irqsave()
>   write_lock_bh()
>   write_unlock_bh()
>   spinunlock_irqrestore()

> Which is illegal locking.

> Jason

Yes. I figured that. But I don't know why, or why

spin_lock_irqsave(lock_a)
spin_lock_irqsave(lock_b)
spin_unlock_irqrestore(lock_b)
spin_unlock_irqrestore(lock_a)

Is clearly better which has been suggested as a fix.

Apparently someone above me is taking an irqsave lock and then calling
Down to rxe_create_ah(). Calling the verbs APIs while holding a spinlock se=
ems likely to cause problems.
This looks to be in response to receiving a MAD so possibly is a call to ib=
v_create_ah_from_wc().

Bob
