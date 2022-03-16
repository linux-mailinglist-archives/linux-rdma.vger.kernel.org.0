Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3986A4DB5AA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbiCPQLB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbiCPQLB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 12:11:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9785B3C2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 09:09:46 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GEW7SM023870;
        Wed, 16 Mar 2022 16:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=nH+i1q4EXsjUs1L3gqGaUaj7VNSiJBt2YWz79bek3DQ=;
 b=UbhU9/D0KYrVeQHXCrQ2i6MP/PI/u12D2jL+Af8+8MRA3U3/hHk81yYWWp66FeU4b6NL
 BgWmsITijKh1BG7RaVz2TDCQ/zlP05JOUKMtRt2laEx2ZVZECLyPvEDQexeeDdOHNuMN
 nEpoeUpoRFOv4DxqZEpsUvynpe+7af6JD459P4aSw1iyFyjGRpG1TuGNqnFibk8YzmOl
 ZdSf+8mMtCt5uPfkyArGmYIoFRrlfjT20i7yrrh58exiE5YNXWqES7x3pCuE/SbRatJa
 wmaOOmAGxncN6bsW2Y1epy31jDQ+1yyPhCG7FmPtVAETEV4j6En0qkxzv6kMSbPd5/SA cQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eue4q44md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 16:09:44 +0000
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id DB6CE9A;
        Wed, 16 Mar 2022 16:09:43 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 16:09:43 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 16:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoGWWXMeBGS0/UUlmsP10I2FFFwg+hc+URH/W9K9/cALQsSEnzsoXMji0inanOPcdN3wYy7l1lJn/O+M8hl/oDonOsgipEEHHNUjkrjklRp21MfBCt4CgLO8Bqyrmcv0Ft6w/C3d33k9ZQVaeFw1R/sZDLCfZSW9Vn7RnN4kJ3voeP2Lj84g8OW/fD3hAeC34evnNLJbDdbpMk7HQrcoRL3L8PEpHxBI03ZHlyLZHUURfpliQ60zrphzA/KQcAmktCGrEzW1yY6xz73MHaQ4wtLjd2UDBu6Ma0Cthr77LFGybherpnv8UsZMb41Ab7opzwzbchvaRaD5Xfm7Uuhzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH+i1q4EXsjUs1L3gqGaUaj7VNSiJBt2YWz79bek3DQ=;
 b=YxDQDk92IdS0uuOETPTx3QGLRNe90CnLd4cHHqXrnzirXofYiJexEC8OWVzVU0TCBs68W39IHjuWUr5VIma6zGNXWreEw0ZT1fovEC5E8o/dzCtTxsnVgzth09B+Dmhz7ilqclqGgm7f5PbNo7JHfv6KxduKPBu2jwEtOZzX+IHJ41LP5VtIY3FqupvRDdE8K+N0uDwUcLS+ytazquEaPqMWTyBR73SXZId0kP8UWVJC7H8/X6AfqD2ntVFSVUqc75a4EOmXTK6A0+m+BfO1lLydyot2zPs8f8Ra3qCLnlCo/EWMXRWuSnBkGkgaS3JdJcPTqdIbBbP2qrVuH6b0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by DM4PR84MB1398.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Wed, 16 Mar 2022 16:09:42 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::985c:f8f9:b7e3:87b7]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::985c:f8f9:b7e3:87b7%8]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 16:09:42 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Thread-Topic: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Thread-Index: AQHYL1wXiyneVSoZ9k2I7npYQgrGvazBOeSAgAA9nwCAAMnJgIAAAGCw
Date:   Wed, 16 Mar 2022 16:09:42 +0000
Message-ID: <PH7PR84MB1488B0A40B8D6AC313777F29BC119@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220316002515.GZ11336@nvidia.com>
 <883b72de-850c-7b4d-fdaf-457f23d309ea@gmail.com>
 <20220316160801.GJ11336@nvidia.com>
In-Reply-To: <20220316160801.GJ11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee72df24-9576-4488-824c-08da07676163
x-ms-traffictypediagnostic: DM4PR84MB1398:EE_
x-microsoft-antispam-prvs: <DM4PR84MB13980A09C095B15A8A8FE3D7BC119@DM4PR84MB1398.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lt9omlggFfMU8oNvokdApLOypOcFE+FYkD1ds4Sc8mGKKQy1dANynzzJR/H9zTDHi8zDew68szQxMhy2Rkd1UHPxIltC13q7gz6zomQdEo1eWKHyi/bk29G9ID3K+ns32pOBitT4+rMP8ItPMRW4J4vgULHrBXx5gyyxL576Ow0yKSSFt/m3iDN+bDt3fO1Af3EHtjw+jUmzvDBP4y5/4dhQ1uGEcI24P/AZZ4vDip4/XzYzd/gNz8rQTIZM0Wtpi/ZeeF8E3eGhEU56IW/iGI5tGLi8Tqt+pNLsvhlBWP66oZ4aBsTAtpIX3uO1eJhnjGNg3F9KQWuozE7FEe3dHDMAyiaqDemhWmj5rWexsseeoC5sSPYUcfm1JTxyUUjJQCjCER0msPnvCRhHtwHO0/DshGtjQvCzTsJZRuf9j62jc6BQD+CNXVxrm35gCRgJtr682OP+lo+0mJ1b6MV/rYqhpoeZeRCj9WHMV0Arm2Xl0Wb4avYfcWfmzqkjt23DPhjJN8I1puUJc814gq77IcoOvkzDEviHDVuV5VcCnlZsXX3IUwv6V4rVy9j8jvwcPtQ1+aEqtsNyx5hF2HDh5L9mqrUEFOQwGvonLxAzgUajgpYgQi5mVNwdemwaaJnr38AknnI9aPrgUK5v4in0D1fjAfmP8cNpk0ALOZ19qIILJUj5Qhg31Eqzy5SZ87MCypH9BAIHaAqQQ/mVVWQ7Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(83380400001)(86362001)(76116006)(186003)(64756008)(26005)(66946007)(66476007)(66556008)(4326008)(8676002)(66446008)(508600001)(5660300002)(38100700002)(8936002)(2906002)(82960400001)(4744005)(52536014)(71200400001)(122000001)(55236004)(53546011)(6506007)(9686003)(7696005)(38070700005)(316002)(54906003)(55016003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zxng3S4rWVfyByNWpE44MGHaZzkEe++DEuMCalRVjOttjcSWnDoy/ehjG0Pg?=
 =?us-ascii?Q?yb1lwyn1jaegGdj1LngdinfaKQ7JYj3y586RSlXF4qaKFDWaHuQL9iBmC2fj?=
 =?us-ascii?Q?5HACDc2DwU+y7OOTiT6QNf33HPBuacHXORfG0AsAWUIQXO4H9vT0D0kGv7vh?=
 =?us-ascii?Q?TIHtuQzMeyMJs34EsxNSBE4eydjwtFKKtzXua0oFkRVe3q1tpsTvdWllpS+8?=
 =?us-ascii?Q?zFyW0imabKVHM67ylZ/cqBXwJzQdK8ww0/Jm96Lpi2wn4W6sIr8g0uOkFf4/?=
 =?us-ascii?Q?RniyQKBTdm7RjUFWb1A7BUJBbS0Hgq8366zq1sqYLooycTw3A5AuZ0VqCm9x?=
 =?us-ascii?Q?le/xC29xI7MQYQI8/C5CQshx8FR/3Ar4JhmNe9yyW+KtIx88eospwrowwNdx?=
 =?us-ascii?Q?MrdYkxagREOSQLqm26+ogVdl9QxyJM2gVVODACvxTgC8g2kxKJnvYQFxAgGr?=
 =?us-ascii?Q?lDp2S+duspaoDQEnok/o9DjH4MQ41N7XzcMPpoOXaHPePiJhzMUuLb95x66j?=
 =?us-ascii?Q?7V9fji53bGVWhW3SAtHCLRR80ibi/Np1ceRDBlijOz1CCXR9GH3LAwajohzz?=
 =?us-ascii?Q?5+5I9swHS1g3iiahAyhXtYGhOdmZ5rkm9wwvoyF9z2HrONLWRsVnVd4gkles?=
 =?us-ascii?Q?3TCeILeTV+95O/EORc0VTvrJDnUt84GYjxgCssbFEZuIQCLxxQ+Uhoov2Gjd?=
 =?us-ascii?Q?bvkSrUqoY2jKvvzVuebC1AjKQdz301T6QIQJCA4ChZgrPFO68J0GE1AUtd7r?=
 =?us-ascii?Q?9pCzQOOoq2g72mA2LZwkqrcs+tZLQgBhd/jvBEYbJ3Rut1eW9JpQnifVgYHN?=
 =?us-ascii?Q?lPkxEtpj+cGq+0br2t2CogTVoIgIBBuGYvFMTKh8ss3NruRgDSXkpKm23QNI?=
 =?us-ascii?Q?Mpw2IIO0IFfKDqrJtnvcJtitz311INRd0BBh/hI7FLhu3TiuUMqm0sM4WHC+?=
 =?us-ascii?Q?6KMXlcMTWicYF2KPQ25QkEfui99BuyfxF8m5rtvh0eojPAqkHvwH36Pk5Hpn?=
 =?us-ascii?Q?wDp7XeLC7v0JMNmmxYE29mmyrNj+/Pd6c4dyOxN6lqrUWtqx4LLuGj7kfIy3?=
 =?us-ascii?Q?xWEHckzzb3aPW+B47E7Skt11YDfNi2k+S2mg6V5fvplCFRs9wxlboBRGD5HV?=
 =?us-ascii?Q?taNcjazGfkYLg1zw+j5yGI7mT+vPldK5Np8ftT2KY/z4Jau3QN7K33A2XfDY?=
 =?us-ascii?Q?ORoIl60g78KYcWZF2nQMQYeJBPAfMCoH0qZdlL4LX2HghWbnW4qixeE3kp2i?=
 =?us-ascii?Q?MFFoQqyx704Mswlp4NWfFJg30NU6txoSQ5yzEBYO3SYv4yZIA+HNLGYWJ//0?=
 =?us-ascii?Q?+EanfQxdl24z+6+Vn/30gXzrXbz1f/fTjyDcpfH7AR+hnHCEyVjo2BXkGebL?=
 =?us-ascii?Q?07MdohORyWP8ROALV1n6jvrH+e6GHeKJz0PjnCTNZsBKwi0FHl1SOKHEw/ld?=
 =?us-ascii?Q?BJRlRjBEjQur3WEY56Vsjx9+A3x+Kpfo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ee72df24-9576-4488-824c-08da07676163
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 16:09:42.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8U9cR0t+X38xofmJLvm2bd255DmvKMh8e2FYC3OXko12xemBt+k84TLPeZQyslIQTausAAVOlbDi1J7UiZROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1398
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: BhMxtp1SFyuXCUfeyoG-9P4AVKA5sAbg
X-Proofpoint-GUID: BhMxtp1SFyuXCUfeyoG-9P4AVKA5sAbg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=820 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160098
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Sent: Wednesday, March 16, 2022 11:08 AM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool

On Tue, Mar 15, 2022 at 11:05:48PM -0500, Bob Pearson wrote:
> >> Bob Pearson (13):
> >>   RDMA/rxe: Fix ref error in rxe_av.c
> >>   RDMA/rxe: Replace mr by rkey in responder resources
> >>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
> >>   RDMA/rxe: Delete _locked() APIs for pool objects
> >>   RDMA/rxe: Replace obj by elem in declaration
> >>   RDMA/rxe: Move max_elem into rxe_type_info
> >>   RDMA/rxe: Shorten pool names in rxe_pool.c
> >>   RDMA/rxe: Replace red-black trees by xarrays
> >>   RDMA/rxe: Use standard names for ref counting
> >=20
> > If you let me know about the WARN_ON I think up to here is good
>=20
> I agreed to the change.

Ok applied to for-next

Thanks,
Jason


Thanks!
