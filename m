Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F166A654534
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Dec 2022 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVQfY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Dec 2022 11:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVQfW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Dec 2022 11:35:22 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1BE209A8
        for <linux-rdma@vger.kernel.org>; Thu, 22 Dec 2022 08:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsZMI2LSxkmEkh8kf3CIV+giUUw6r6aMsQgI7x9nMUgYh3oDc/3931cOcVozxNxD+tU18dIwRGhFVfkh9xwOiqB9iIPqYK5SutoHO/6ejEMGTS5ITRHkDTriILmDWRcpB17D0bEb9bsNIRibfbezGJGyiamhGuOdiWsGREurZwlbLXEJHWIVqEN+i3Zhivl8dwvWjye/mEP/YzbjPMXSpc9EmvIvpnZreeEbsGmI5atO34SXrgkhLkSI8x3rr49pTDn3YoW4YDWetifcc0BETkAupiw/74kgmP9/x/sPZz9sYISPuMcgSZr1hiCOCYy6ixp24brhr5DTcuLJFR6bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBVL0xjqNfnBkzR7SEoHADtPGJpsx7V517rKRuov9IY=;
 b=ZdQSHa5tX6M8bAxmd7V5jdDekxXtty9YeCyKCCnuSgi6mVKxxroWm9V/Q+WkqDoxhcTlsagYwcZ+eon5C2A04h7gCCja7ZfvzN6fEtSM0TajTwA0aeGj7RHJ5XJLClTI1xshkSKOu1aFD6RxIl/XYFaBcd93h9Jxz/M1qEyjkyzradfCBTpbTathMjs6olYDSKHz9Ko8eTO+BTJKsrx8L9SuBP8xyJ1mAg1jDKxk96VvcIC7fa/njKn2/D7kiutGoAsnU3YyQ0LHPFUtGD6izH+y1Ggw1RrB6YA+/7Q+DzvaRHjs0Dw0uFwtirvKPYPGT9pRg9Ftz6PE/Q2aG8zkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vcinity.io; dmarc=pass action=none header.from=vcinity.io;
 dkim=pass header.d=vcinity.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcinity.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBVL0xjqNfnBkzR7SEoHADtPGJpsx7V517rKRuov9IY=;
 b=WKyrq0TD/54wlDqJgSG0qwQCAizsR6IFQUzCvo5w/ZcB2fk7Uw+MF4Ez4mbmidWYrmmAp8p/tOulQfR6VmAtzsjAikIupTwjMrrj9elEfBPskibf+XX8jdIvO/vsArKEiyNRfaM9BBpQKPtjEz4Qx1l/BIesfHtimlz7zL+t2GU=
Received: from DM6PR03MB4907.namprd03.prod.outlook.com (2603:10b6:5:15e::23)
 by SA2PR03MB5931.namprd03.prod.outlook.com (2603:10b6:806:119::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 16:35:17 +0000
Received: from DM6PR03MB4907.namprd03.prod.outlook.com
 ([fe80::8ee1:2ded:9ca2:a333]) by DM6PR03MB4907.namprd03.prod.outlook.com
 ([fe80::8ee1:2ded:9ca2:a333%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 16:35:17 +0000
From:   Suri Shelvapille <suri@vcinity.io>
To:     Jason Gunthorpe <jgg@nvidia.com>, Chao Leng <lengchao@huawei.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] infiniband:cma: change iboe packet life time from 18 to
 16
Thread-Topic: [PATCH] infiniband:cma: change iboe packet life time from 18 to
 16
Thread-Index: AQHZCpZ7kZOudhGqlUWKIBQi5M78Oa56MM2Q
Date:   Thu, 22 Dec 2022 16:35:17 +0000
Message-ID: <DM6PR03MB4907B39444E17BE854927F3DB9E89@DM6PR03MB4907.namprd03.prod.outlook.com>
References: <20221125010026.755-1-lengchao@huawei.com>
 <Y5EmWTRqSJiNyX76@nvidia.com>
In-Reply-To: <Y5EmWTRqSJiNyX76@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vcinity.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB4907:EE_|SA2PR03MB5931:EE_
x-ms-office365-filtering-correlation-id: 508da290-6092-4718-748c-08dae43a8293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vm+WU8EFu83zr88XQ2rjmxNC/9ygzIjlorBaEKbf33+qX09/SoOIVvCBewcM+qBCKh57GFPoivplUROhpYCvWd9t9nlqThAMdr5weTxyp44R6ypd9pMVEeToAlkKotpZo7ACnHw88THUakSWMre6qqiRaEOzBgW0jGA0Usv+ej7hlbmHNA9hzVEv1jXFfUAGJNApAymOtmy0194nHfiYdjJKK2IXNz29be3w89EldGq+lCGSoX+RJ+cIjHByE04jHgtnHJiNBbSkdhyad4VeGF9GxBEjQy/K09m9fcd6d7VNWMNSslRMr8zaGc72ARsr0RZQS5A5/ILNq+4DNx77jUPeShfNZC+eLPIIw9f0VhE4UznrGHL8GpxDfW6BKAsrwbCvILgtUbgl/oa1ozAfT4BFOVSqzz6fJrZabISN3bkxtHMDORakqabpfNBYCyu8x4WlCgBHjg+fFdwujgXPtWFr55mtl5fmleGSFdY5GNTs5DVheW3vZodQxwl5fKWLycLCXyIggcm72QJi7P7qTQ7USNgnH18VtGenwNll+Cii4uYvDumiz3PrbpRdqyKIA+YUaplY8L1QjzQiUvFRpOdd7c72jm3dHBLM7fbC9j09zQWen5wFe3ZNf0dGQY5cf58MHGHi/1K17W1D8AWYn3PswuAkGaqpcC8Va7zj5S1QJveQVzFbHWiE3Fm1mVnWE9XOLNYYvdy2fCOD6d6myA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4907.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(396003)(366004)(136003)(346002)(451199015)(478600001)(7696005)(71200400001)(6506007)(66946007)(66476007)(66446008)(66556008)(26005)(64756008)(76116006)(186003)(55016003)(9686003)(316002)(86362001)(110136005)(54906003)(8676002)(41300700001)(4326008)(52536014)(8936002)(2906002)(33656002)(53546011)(5660300002)(38070700005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?meLhECJRSnpBPwKbZhFMTGE2ntG8iivj39KunBLdW43lRzUqyya29496pwCd?=
 =?us-ascii?Q?GSrNGEyY/i4znV2hQGbWxL2wXfhSO6dBKx5AhAP+J/uGHlVUd+/Ne1Jnu1r7?=
 =?us-ascii?Q?agqIxDsKSzYkiJ+KZ5ute64y4841V3M/3tPB98ANxTXKwq83rU9Fu0kbT4ZN?=
 =?us-ascii?Q?oMYLw5QYxtuRlp8BCgp0CKwB8TyKitpjhfauHT2a1L3V8dtMA3HMzYJPuXPW?=
 =?us-ascii?Q?DcHP3gDRbmdMaRbF1clR0zEMEUytEw09S96+RfblNXe6rzRRYkjir9Yqjhvb?=
 =?us-ascii?Q?wSvqs0kZgEcjkbMO9w5K+3TN51b+pKuMva1oSCdR8zUJd2ALe7OdNhq86gJn?=
 =?us-ascii?Q?PlUuCIoOtQeXVufkpIGe2s11GhSqnkBrOXe6mk4y79e6tgvLj7BIO6Ot/H0b?=
 =?us-ascii?Q?g/vMOutQDW6N7n7SnU1Flixcxm3yw59/VwehLSMJoDOyW4rzQRCOjCqnHrWJ?=
 =?us-ascii?Q?m0h9gJluG7IS6Zisw1SkK02/J71EwcoFMThToxgNTqM0Avm7GjkzSElpttNN?=
 =?us-ascii?Q?hHK1OQuFeMBeeXkSibZa4kOzN53BLNLC+bvA00ty+YE5+WEltdXIcAc/XAlI?=
 =?us-ascii?Q?aCrI2hsyTk8TZ5SCNhndS3+Ud1N87Rdxcu6aymqJ57qB7SjCfeCgY4Z9RMXG?=
 =?us-ascii?Q?R59fpD86k8JmbQUCPNkDsnZ4zFxlhbgFujNp36FsfTcqat/qmJw0j2x9UjKJ?=
 =?us-ascii?Q?G27ffZF40k/22RZKdjgE0N12TuN142kVaoSIr65cCT9DXDop1CIgA90lLpwf?=
 =?us-ascii?Q?aPWdCH0jz+rfhfhJQG8ShmvsREE+0wlhlXaG5r4BeQrtwl3lMO5Opxg+bbEB?=
 =?us-ascii?Q?7ThcrWMxk7ZIpuUNBdHfOtubOBwtKg6B3coNqCQIHjnPszl06zRi1JwyFCYI?=
 =?us-ascii?Q?S3agf68npv9vJ8w/FryaJ71Gf3jrei1O3aQzUVtekLyslFjsj/KSHhRh4ZOR?=
 =?us-ascii?Q?+tjdYq+FdywSQDMYa1/YHxPcuGpiEZdLVRoSE/Fw570jFabIYRvISj5PIWjW?=
 =?us-ascii?Q?XCQlGM8hwk8VcbnsJwprnjx3NcFSEjtoLbzATamjxNUdCQrnF3QBZc2SI4oY?=
 =?us-ascii?Q?tW6ZleG1jIcMP5vtw+aJ5fouZHYJ/qEPEgxLLxKyYOTTmQb1b/TYIQXXubEO?=
 =?us-ascii?Q?Fil+TgznyoA7EXNzb+oS0UeHppmAO/j+E7JjYcgAnrj3rdEihib7L4L9LXF6?=
 =?us-ascii?Q?8wyscS1XDMBYyIAcC21YsSkJ+qzjrZTeuz6iP0cRKzuhU7TLNsbWq46OGKLL?=
 =?us-ascii?Q?XDwetPALomNsOJwFHy01xEiJ3ga2uJFmOFX7vs1top7IGOAUXVOPtURIOz6R?=
 =?us-ascii?Q?UlYRTl+BtHxH9cEfSuuCGxCvR8nlAkplOYTZs6/NR1H/euWqx8Z4ExK0HGPZ?=
 =?us-ascii?Q?BQFGWvT4W1KSLH3zNKSRVmhdk0suy8jrdZL28zMp6j6pIyuCAPyMWOXmJY8Z?=
 =?us-ascii?Q?hqxHmO/kuEeKatBkO3Z22ut5mWB7dc4ph0XkrQDnNiewOy0B/Zdq7BRLB3IA?=
 =?us-ascii?Q?Ayw+cX15zoZtzHDAJkXOYhehJ5H8W6dNadJcfhQ0qiCXK3XKQmNn+fHpghIN?=
 =?us-ascii?Q?ii4RAYv9ny5OIXkAOhk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vcinity.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4907.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508da290-6092-4718-748c-08dae43a8293
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 16:35:17.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aac3cb3b-f625-4cbc-ae65-2b4805bc1fa4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJ4YcM70RUewfkPZQ2P+X4ZIz/FMC0A3F+ALjdbexbdJGhdlF+OwgKkHF2XBH6M7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Is it possible to make this parameter tunable? In pure IB fabrics I believe=
 you can....

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>
Sent: Wednesday, December 7, 2022 6:49 PM
To: Chao Leng <lengchao@huawei.com>
Cc: leon@kernel.org; linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband:cma: change iboe packet life time from 18 t=
o 16

On Fri, Nov 25, 2022 at 09:00:26AM +0800, Chao Leng wrote:
> The ack timeout retransmission time is affected by the following two
> factors: one is packet life time, another is the HCA processing time.
> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=3D2.097secon=
ds).
> The packet lifetime means the maximum transmission time of packets on
> the network, 2 seconds is too long.
> Assume the network is a clos topology with three layers, every packet
> will pass through five hops of switches. Assume the buffer of every
> switch is 128MB and the port transmission rate is 25 Gbit/s, the
> maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
> Add double redundancy, it is less than 500ms.
> So change the CMA_IBOE_PACKET_LIFETIME to 16, the maximum transmission
> time of the packet will be about 500+ms, it is long enough.
>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

This correspondence, and any attachments or files transmitted with this cor=
respondence, contains information which may be confidential and privileged =
and is intended solely for the use of the addressee. Unless you are the add=
ressee or are authorized to receive messages for the addressee, you may not=
 use, copy, disseminate, or disclose this correspondence or any information=
 contained in this correspondence to any third party. If you have received =
this correspondence in error, please notify the sender immediately and dele=
te this correspondence and any attachments or files transmitted with this c=
orrespondence from your system, and destroy any and all copies thereof, ele=
ctronic or otherwise. Your cooperation and understanding are greatly apprec=
iated.
