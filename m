Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73144660960
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jan 2023 23:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAFWOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Jan 2023 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjAFWOH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Jan 2023 17:14:07 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297750E76
        for <linux-rdma@vger.kernel.org>; Fri,  6 Jan 2023 14:13:59 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306L06Dm020557
        for <linux-rdma@vger.kernel.org>; Fri, 6 Jan 2023 22:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=vwoIq5IWHu9YDOmSEhkLjSpDSvgIZcfuEUVeaBmxNrk=;
 b=DX/ZHJaNxqfTBmZnIGuGWyj/XeI6yyEzGpdIr2Q/N35D3G7hEboEX1L6VA3XnMeShJDI
 3omcH92xfKe348qGxKi7X5Ttc+Jx3HcGhzcFAp0tyVCnzvCaXvaPvWlRQxKZbbmjRveN
 1bDvIQ2MZmnosN/xXeXPy/fJibBOJLbF/AjnbGG6abZyiXBK5j0eHIWCvVEXyMM+Ovkq
 ilRSTW1AHm95t0VgIks2wLwe3STyff4wASVHUieltox1YvrrOeR3MlYiOQMXl9lJlPi0
 Iy2m0xaJW+TD+T6INZ4jGqLMDDhVlO6vr06ZXEckl0HNXbK/BqkWLPa/0j3Nu3PHk4UH +w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mxu5q0bv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 06 Jan 2023 22:13:59 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9CDA6301AC
        for <linux-rdma@vger.kernel.org>; Fri,  6 Jan 2023 22:13:57 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 6 Jan 2023 10:13:57 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 6 Jan 2023 10:13:56 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 6 Jan 2023 10:13:56 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 6 Jan 2023 10:13:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doFGddcXka76iTHRKOOn9KObmR4Ei5wHZOu4VGX04D/xsSdV4rWP1+az1Qb3AJKxJuKaAwZ9MtAIlF2GmivBa+igWfpiiLGdEq7eYI9UrhqjjBSL8kD41hLQU28g3BttdOLoe307+d00iF4cTGO0EceCh77tXFtZoyoFG3ORGcHdCMzBECq3PPxzP/UdKPTyO4fAhqBjLA3lYOO9zzoZ8pYH3ASCMHRW4QAQBv4n/mkEb2WrNuYeMw4PWFN6yjhen03EQ5P5UFJldjHN64NpEmW60s3DYecF+l/0uAZ2rCMmA02VW6N5fOLMsDSZzFEwq0cRJixRm2pmVfq3tKlXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwoIq5IWHu9YDOmSEhkLjSpDSvgIZcfuEUVeaBmxNrk=;
 b=Efqi2nd80yo9/87BJZSco243PiSJTbjGAP7p0APXXJu7uk3IVhd6eGetrOsjGN7ibhKbO/UX24EVePfPQpFz/JaDlY4kg3aMP/oySBS10G+ADyG8E2vrqMVdLIk+vWmKg9vAnCB45wtFBEDBSc8MS8je8MjnPPmgwEGQMgNPjPM6jYdklQjr7TUM1r+SHtjZ9CW+wtP//RGoWUjBlJVG/HPQvCiHn3wtwSWsyakI5uSkmQpAap7yMqkQkHKKNXFqgkpwx5LIfYXaipYgv7eJFOkmvaq58lv0rWd66CgakYi/py+QdrwZf88X27tXe73WHljEHGFeBJ0lpEUn9xd0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:9a::7) by
 SJ0PR84MB1651.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 22:13:54 +0000
Received: from DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6506:b63d:b237:5590]) by DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6506:b63d:b237:5590%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 22:13:54 +0000
From:   "Haeuptle, Michael" <michael.haeuptle@hpe.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: rdma_create_qp_ex fails with EINVAL
Thread-Topic: rdma_create_qp_ex fails with EINVAL
Thread-Index: AdkiGeABkWPnBYcZTnSqb1ZbVwyQuQ==
Date:   Fri, 6 Jan 2023 22:13:54 +0000
Message-ID: <DS7PR84MB3110FCA7FD0A05FE103DD85495FB9@DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR84MB3110:EE_|SJ0PR84MB1651:EE_
x-ms-office365-filtering-correlation-id: 4ca45660-8895-4f60-d6fa-08daf0334c97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLfFBnQzipXlKExdwY9Cdoa8udMIykUJw76RbyWV181a3Aj2tjq2+x1/nmfigR/gFHjSh1vvw6FHF+mYVYqEEOqNrbLM4muRcW7VfXMY8VX4sco7UkOXWThlFnjBvQIPkOcNiV7omk/zkSiQsWuo8h5mNQXDCtipwd9ij5ILU368Z8a0vNPvTCrVHGBnHnO0zyoDfZTeE9iiQTiv4EB0EH5z1fuonPJ5JzqTFC8uFYzA7vMmTxgkq/gcZbYqVoXCB/u1IpS/whvkHtgVBkOsKzmGJ8kBdhOIuJ08Um+GLTn66pTAcyFDOlccPoXD+hTm8cdFXw/5l+MVAIsSPW/5L4HzXCZyFgU23JvdhsLG68JCR5HdSgLg80npY0UYURwxLguJhnRKQAJtFx5YLkj3+7XQbLDu9jMhauUdDuKwWw9545/3HFbt5ImWBSe5xmXwndPyvTRRX1OFOIDhbGCdxh7ad2N1KtIYNfNzKG5N2Jx+WqsBvVvDkuHmq5fgTB/m9QH2Q3+Ku3Wur+XCLJW5xe5vgIUT9YVw+g5S23FGrHPF8B/bf2JfjmNdlhVM5JaMzqwR49drnNNUVeE7RTPnhI5kN1moclpDqDrNRyEyIkSr8yBipxqImdOv4DULQ+iYgYhQ70Q/cNVmV2NFC8GQ5llREAvlh2JEpcs2OAnA3NclUVNyoJl3QHdpidRZpcn9Mb7CL7fPFV75Z/PCGT3NMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(41300700001)(66556008)(64756008)(66446008)(76116006)(8676002)(66946007)(2906002)(8936002)(52536014)(316002)(71200400001)(6506007)(7696005)(186003)(478600001)(6916009)(26005)(66476007)(9686003)(5660300002)(55016003)(86362001)(83380400001)(82960400001)(38070700005)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDoGIdb2ivF0WcvUO2V8Q/CHQF8TB96KefyJS9+H5YacSYOGVAV6sEFf8WoB?=
 =?us-ascii?Q?3oba2I6jbvCAVQeYOV4nu63LnJ+Auve9K1EhXRXtyTS142sJ2NeCmDtEgC9J?=
 =?us-ascii?Q?9DgBJQET4Hyc7trEykoOW0qG2Uh+9yOcO3GG3P2651T1F5mrPBDeIbBcFJ7Y?=
 =?us-ascii?Q?3+5NctebhUw5SyRnbC35PbaYymGdQpYy9pMZLQ41aluA85lzhBG4ldL/G9y0?=
 =?us-ascii?Q?HG6zkZo8entlyGnNPAuW0ovCGUjABhaZ15YFpTfxAVE2NBDZoKY7ORvE+LX6?=
 =?us-ascii?Q?xA9qc4vA+aku7M+U4xqLMNJ4/gD+9OzG335cjouCofYYZDBpE9ba3uiStHIJ?=
 =?us-ascii?Q?h4br/4vXSymp9dgZGCfw8zzdSygzEEi5AaylhjiBsY9No+8jjCXsOmv+Tglb?=
 =?us-ascii?Q?7PnSKc9/nhIlE5Uy4h3yVWMpxbGCIFb+ZbhhHOsZjB0CZhfmwIGPPJKtFGMw?=
 =?us-ascii?Q?r+FRtRyPHfTdhfyjwAyfTgjMEjrRIfzwFA17XpYMsHe+hRHkVhDNUo8PWOfb?=
 =?us-ascii?Q?LADwyR65wS12ofOFFAOaFUIPLw8CLQwnu82V2sLqA14NWTNVgztAkQG7tTfW?=
 =?us-ascii?Q?OWPZHFsj730o9Cu6/m++DiuoOYnBszCZTST5JBMYEQ3GmEIwGpVCF1GhKyiE?=
 =?us-ascii?Q?fXO08spYRewmxTgAlWZQQoxrfsqCg4wdVWH5AfBjTOeQFzymn1oi4BVGimem?=
 =?us-ascii?Q?O3hpYJExWTk1K/J0a1uMcdhCXZq7RaD8vd0cbBGzoqCjLbeq/rmQrdjMuVrt?=
 =?us-ascii?Q?gMh9XMScuTayRXW1/Sk1kVj1m3vagz5+8yuShYJlcTDANF3MRiVkOU23vpgA?=
 =?us-ascii?Q?dC2pQsqR5dCG9AySFeY+YheYfZlDGUW7WULJc9NP5LvOuS/zJEWiBnq2+e6R?=
 =?us-ascii?Q?+y/yacU8pRZHpCKtVGdI1//XOls1WsKEmFwDWsLvC9dcu81YX8QEAa9HK725?=
 =?us-ascii?Q?PO4oIpcXjnnPJIXWfIfsaV80SBylnS6ZkHpBoyKTzESDCjNxWhuuPJ39gKuh?=
 =?us-ascii?Q?8A4M4zymbvZQV9l2ONuzByAGPoZh7Ih6nJ8MZX6DpSTsNwi9wVj1K1tAYYnv?=
 =?us-ascii?Q?IR/zic58kh1sccw1wB4M6frhkaiuRqUj0tYnJ09oexKy08prSHxsJauVXNgR?=
 =?us-ascii?Q?I8qVuADNhHb9VAq5mAc8KyT8eh6zmrfD2icvT2P/QZkhbt2QTLHyo4GsLo7Y?=
 =?us-ascii?Q?bwbE9yGzDQsOKWRvjXBIhhksxzOSSmwQmzLNdAXubZEPLFOA3QIThR4Juv2M?=
 =?us-ascii?Q?N6mEzP+LTMLuTZLI6mgop+++ruQzVFBK0UvvGu8xfHj+f+0SmFuBQ7ybJCqK?=
 =?us-ascii?Q?tPFnlxxoHNDcb38xX4SlnJOn6wdBeCx733PFKvol31j7o3mIdVX1HxXz7NRC?=
 =?us-ascii?Q?Utgodef2wQ9npM+PXUa9WPM7qYww6y9YT1JZ+orHqR+CXYhQZOI4nhEUJbpN?=
 =?us-ascii?Q?Sjc9TGf2+B/2JWGGmVDvDt2ie715RryLqwqPNQRTUk5wOIT9kLHF/PpSI45W?=
 =?us-ascii?Q?HOE7KYpntcrntNwKSyINFIc3EAks/EUVDYPQuzr+XtSaKxtpzoGb88H1vJrf?=
 =?us-ascii?Q?LZQgZ4fUqETN/GDvZFH4I7R9Gkpv2zfxZSSGy3z2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca45660-8895-4f60-d6fa-08daf0334c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 22:13:54.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXn9HA9oN1EzvPrZttTPeHiTSV0SBlG9Vh0gGWzPwW6U8XbuN2V4naBp/wWlVAh+l0CuwmezwZKJxP5Fm0SaslmhFRCd17rv7OFPGc3psFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1651
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: LuYzUKNQp42l68hqmL2njhHh5nGRtoVC
X-Proofpoint-GUID: LuYzUKNQp42l68hqmL2njhHh5nGRtoVC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060172
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I'm running into an issue where rdma_create_qp_ex returns EINVAL and I was =
hoping that someone could help me understand what is going on here.

The function that is actually throwing the EINVAL error is the write() call=
 in rdma_init_qp_attr (which is being called by rdma_create_qp_ex):
...
    ret =3D write(id->channel->fd, &cmd, sizeof cmd);
...

It returns -1 and sets errno to 22.

Note, this is an intermittent error and not always reproducible.

The setup and scenario is as follows:
- SPDK NVMF target on Debian 11.3 with top of tree rdma-core libs
- NVMe-oF kernel initiator, Debain 11.5 (no change in rdma-core libs)
- There is a switch between initiator and SPDK NVMF targets
- The kernel initiator is taking to 2 SPDK NVMF targets via DM and round-ro=
bin (I don't think this matters)
- On the initiator system there is a 512k block size fio load against 48 NM=
F subsystems (2 target apps with 24 subsystems)
- When I kill the SPDK target and restart it, then I occasionally get this =
EINVAL on one of the queue pairs

It's unclear to me why the write call is retuning EINVAL. The file descript=
or should be valid since I see the same fd in later qpair creation requests=
.

Any insights are appreciated.

-- Michael
