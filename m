Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72A74748F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGDOzX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGDOzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 10:55:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6361F10D7
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 07:55:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EibbU001584;
        Tue, 4 Jul 2023 14:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DJ4GG26HnvcQuEAepp4fCzgJtmNuuBCpD9DYV9iuvns=;
 b=wE1s1w7GaTSpVXbtZYOKjiOGtxtf6A7Q7S4KlcH0Td+yBQFmeW1FXMtjct9dnjoEfy3E
 WchX0CfV7zhf2/Rva6UVEPQdS5oEveFNz65foiw67rD/N8QmATjKoffaSrjPcvclxciz
 kWo/Gsuzcds37rLdBw2VMFbat/31s3WsJ9dAEdqIvV5ypgRzxdhj64fNwum2NqAo+qTI
 2PgdTxERJphHVPpEdYAA1nBQyKTjlbKd2XHmeo4LHDUg0AOCw+aOygPMzbyQYbDohYk3
 VuCFCrp9xAnGJlJ2gGiYTqZtctgm7Xt+beAhG9CNu1VldM4ZXNhnUCQXGcnjxAO996Jh zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpucq65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 14:55:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364EW22m009039;
        Tue, 4 Jul 2023 14:55:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakag4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 14:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB/JF77aQpUvGEgN1zhsBDUcGBC1F7xrsY9ioN5FP31BWrVEwrObH+aXi9QW48czVSLA0y4WfiyEd0vj79tLsGVp+RkxSc16+zGzXeSEQIiWzkHs6M5Detp1N2AeQ6u+cKWDl6wo+ATgS3efGGqNH8N74kx/36vRVEu67pmSu59tsvkJMxw+BXVe0O+CNUthxmkO/zO+2hUhvyRbKBkJe39F+rb+6IIAgGiLAcwSO1LQKBizlwCv3l1vNlMBW8WJG+nTFcRWd2c8RWFOX5lDVOVZ4lzJ6OyvLQYoEYIZYaAt+gWZWpDugquMqU7WFo5W47ezy86zPTmPUTqlb1Scbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ4GG26HnvcQuEAepp4fCzgJtmNuuBCpD9DYV9iuvns=;
 b=O2JWi5Q4M6nfTGX59AuLo6jjUnoJkLofZgdazxHT/7XdVikDoNBC1Sx+pED9QuJ+r5uKzv6sMzHJrdkuDTgU9CKl+9TwSkAyi18u2lV+BiBCTqa8jKzncBhs5DiqWuIhlRGgyRbNjJleODRPPtmKpqXMI6GO76w2Dw5Omeb2X1/Un2SZxefOvsEuB1IQSQQMwkYqy2KvbAWOiCveKktnpz8GUpxE1BzLskKcEtMWua9lvvr1UNLQ1bZxoW09bkCtxNHXPaIHOPT6mVxVEhycFEkm8OXC2tgHrVw4V5qKgw69Re6Z/gsIvI9xN4bHLO9bhhk6ZybMScHsnXbm5wDXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ4GG26HnvcQuEAepp4fCzgJtmNuuBCpD9DYV9iuvns=;
 b=Vl4IjBbWI9y9Zw8yryKNfZG7fdWZPSO6hR9m1+u/l4z6qq0cx0n0UMIjbWpVJKwss8a0jzhxNdDZ49H56MeHS+GgdcMEOBOYb/yBgN8eaUDywf9YHYKA6xtOTrhgVNuH5ffCj9FUACihq0hjyXVhDNm29jSKBVLrsco1/WAzW9w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 14:54:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 14:54:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Chuck Lever <cel@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Topic: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Index: AQHZqpy/MPzrGTHOK0uAvlJLASL21K+lG7GAgAAA3ACAA3LzAIABIZyAgAAInwA=
Date:   Tue, 4 Jul 2023 14:54:59 +0000
Message-ID: <50C32C40-D3D8-40CF-B332-C12FEE894FDF@oracle.com>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
 <ZKM4jM6Ve5PUhHFk@nvidia.com>
 <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
In-Reply-To: <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5143:EE_
x-ms-office365-filtering-correlation-id: 95d67910-d5e7-4f64-1d91-08db7c9ea362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6HPzhvB21rACl7ZmndSDSCY0q23R397U1wjXQo0lvo8/2r3iZKND7VCdnv9jLgpWX0pkMlS5BSBwdth/zZovXK4FlkudgwWhQ5g0dOxYrJHwuZaIZUHbcAEbqd+Zm+2hLlx0qBizEkIwn8btQIgrJ0TmwRTr2QCMfTOf7uw0ofwRGuAFjDbRc8P+BtF1u/AuLtZUXuGccHJU7YAJ9Ug1OBlmc2TAVFmHJcdn9+V2q4aHegM16E1OnPFM9jECBxaSpYsG7HfOuqLjizSb2pl4v/LIOENoEhqThdYpMedSaLnuexK9cuYV0AF6mx+hQdezX2XK+Em7xqB/upWIf7bgsMWPlO6q/2ke7XAKXmI1rsjYv2oGYb5uEFRRBfr/m8tW8ES+kgt/oCqb6LyS3EctEY/CnyaqdYKjEI2Rv+asgOw8ZjsCrWLfQi7ZbiFpUn9KBGaKG5ZU5ew1i6T+iXAOlRL7NI7HbzcBLwhctBATYD3ih83Pp9/r8daUxOBAbXWL6tMH5fQQ5sJwObze7S8evwJaed1nE7RhXI8oVqZzlWkgdZMSWCYydZPlemmiMFdpqSh1UNkHm0xpTLzCK+1+Y8/A4yURa4l7PmUpgiAfBMvtgPaHCVJOr+vMWlZgE9rNt37fhSWgno3e3EmOiJNXNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(6512007)(6486002)(478600001)(54906003)(53546011)(6506007)(26005)(71200400001)(186003)(2906002)(6916009)(4326008)(316002)(64756008)(66446008)(91956017)(76116006)(66946007)(66556008)(66476007)(8936002)(8676002)(41300700001)(5660300002)(38100700002)(122000001)(33656002)(86362001)(36756003)(38070700005)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8GyYN43QABmSI3HqBe0ad3qzIV+7xCEaAPtws/GceEXs9gNlB7eZgQ700uM?=
 =?us-ascii?Q?SfHSoYTIMu75/4vwQvdnwnqC+rCwcPDdiIxYQTgkA2AFdoKU1baa/g5RgG9R?=
 =?us-ascii?Q?oQHqWXG1TF4BdkoBBq1gnqN6XB4ut3V4Age4alu6eRhu0J00FEkB4HpOHCbb?=
 =?us-ascii?Q?vtmi7/dJ5XmXXvfKxzDfqoZMRzjE8jgdtby/TqQFdmdy2pjLt+t9XJNGOXFC?=
 =?us-ascii?Q?cAuPwTtmk1lWpRS9wYUd5VBALAvvpx2mIcUQeBbxV1zWaqG8AhQ1iKqbJ6/k?=
 =?us-ascii?Q?Utk0/VqC2TjJkecV+oraAyX02A0R4NRlEdct3tpI8LrHni7CGc9YzvDNgtYu?=
 =?us-ascii?Q?OYJvO2gO51nkgEykjeaeCf+C7FBsk0SVTojcJx8XDXH0ymRWt+VEAzTAuZ/H?=
 =?us-ascii?Q?GZfYsZcYOhM9sb6KtWe+AhOY9LslTc0FgH/pFYGx+bLcSqZNVPX+vd2qc2pr?=
 =?us-ascii?Q?p0Q20HNV6sX+lb6jySDHVNl358xeeROS0DN9isxtv9FdE00115cR0r9RD/MF?=
 =?us-ascii?Q?HdnR2XxwumTmAgMVwa5PM5KlLs1kjOT/jTTLN+Za19poOhbA2TurqeGGV4i4?=
 =?us-ascii?Q?PzQ0Qdzdv92Wwjf84rZnLcQYlqP0CahfMyR/tJ8JUBTtTr+R4TDB2n52mEvu?=
 =?us-ascii?Q?NqpM5skazxJMJgmfq58QknHfzAiAIVspOfFFIkpJpDGXPvw8gBR6qgGv4KHY?=
 =?us-ascii?Q?LQg30yH/gXbogzG6sGc45VCcfX3mpvXpvc/ecBX0yPsBUbHJKkK/JQM3XHV2?=
 =?us-ascii?Q?5tQJ9pPtjGGu7XRat2svoMcFU08mYc0xC/9E6EVDxC5pX0iHGf/PYPBosF/1?=
 =?us-ascii?Q?YiN1tmMfvahoXQAzWwmg6niMWhBGFV3p2579lpLrLfX9AUxf8rfcBYO9yJx4?=
 =?us-ascii?Q?mtEWptK8ltBEyRJZ+flaQ8+qMNasDO1FURD5ftsbPnze2NMwKKj8QBXVHbvz?=
 =?us-ascii?Q?sT17vZNlscODz3/cfTJVrpQ2TfQLRuFYlCI2fjkqfOBpKbXgTR7v+n6jyRsE?=
 =?us-ascii?Q?hoH0w0lztjZugflsNRuLjsXNYbsacoDhJoF3YpeWTRJ+RVTeL9NC/wC/f+Mk?=
 =?us-ascii?Q?8e9072MLmwUfUq/wBaPpxzo86BGD79/FtRJfliWisvGtSqAqkP+sPi9+Hwa8?=
 =?us-ascii?Q?1+sVOsJx3/ugVr3kMqNm+vWWBaUfDBvL6MtNAC20oGmGyYVU4DVO/1oWcQva?=
 =?us-ascii?Q?I4xFFo8ibVOD/qNu6pHnok1ObZiogRf+PK6tt79uMVBobv6P5Kw79+WSkFxR?=
 =?us-ascii?Q?/wkyKdm3GBB0FTjUk4cM72gv058kTq5CHlmuINFaMhJqB/fbhhN9KqsG9TKB?=
 =?us-ascii?Q?ZmdP5ZOY/k9lJz3JZ7j5aLXIhM1Z9q5bJNWaTPRHLOX73Q+sD4h2mSLO/+As?=
 =?us-ascii?Q?857VZrFJoqDSYkEpbAyiySs3pzODxC9e9TqEf0IHuEnowClaQvg8jJJu5wDc?=
 =?us-ascii?Q?4R3QSvDUAO+RRX5h6TrWFBsTpXnFXxq/iL5r78pb223QD7ZocEgRs7cvMBnt?=
 =?us-ascii?Q?8tYqxAbBysjPmlinHvZsvBLDO4dgdOK2SDy+1Fp3fcoMjRjmlzhRvhKT+KKs?=
 =?us-ascii?Q?qP9p7DsOHWjBsBttbFS5nscHpWNIwKkkHMXLhugc1I+QNvkwLql+FcfmCZg0?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C235891FAC984C48A95BF4F1C6414190@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5FhnZat9TG4Fi+Ptm4aIiEBrfC2vF+FD4rXLpFOtcowznuW215TW8uo/B6v92GzUWWCUmVWalAT5n/nm9YELoA+3vKmjVHYzYCMYW6Ee6Htd6LIfkOlmanQ72DCGz/8ZraUpmdhpDSnptrxEyipPkmc+lDzMNmWlSf2ME5NZNRQPCFmTXCm1MZF/0zvjdftMgvbvwMmNH7T4jrTdcxy2YicRwdl3NzOjHlHKv7KX+m6TDVJ5QXDGbef1fhtfe5qfF6n94GXJfU8LqQyysYQK6Shn55u2J6vB3oW+0sdMD6YUd04n9ozb/oGXEUp2GlxlJyYh678gJr+AlQ/c0f/lf3Tlz1SMMlx/gPqsox7OZ0xoazvH2J0ttsMCq/sCNOIaCzxtMHTbr8xWISyHPBGrFLyTVHuWOrjOgOPHcIMJDitMAgAhlZLXT4Cw5/BAVfLtbV6WMqp1dj5dwkr/KZaUenay5jiNLnX3QspSqqfzM0p1kSdlQljwqVlHKkVs8Ct4zYNvXBTtjJv/GQqwB/9p1uypCT2wFydH8hC67SRJnCJil6nwJ56gejBGtEWBMVcJnpOgFtAVv8/IwxpmE2o6DQNWaigG/Yip0sQ3Uad/0BnbbHjnxTnC88YGdqxV3bJqFVKpM2lZGPFPQkhWYYfqXuXpZ+wlsZj3P+9UK/qOwQtMFkZXWyaviWniJDx9sWzGsJNKN0Ql5G7en7l3Ae0KLcivgqiz6+x+92Vg8OKUR5Gz5CQgS3Qht+Enr7gphTlelxlDWmtU1jVRk5Nty+OvQ9y+d5H8iYXRggcmzxq3LM3alvLNxpmgIby1u0bQeA4hgprXT7q3W1136pLq6399z372T62aNFovxq7o1TvGVg2ih6l60i/rJqng5vyLMBtIobtldgOz2K4sLYIEt86VZ41nwEs2zxn9rp29EiL+/OQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d67910-d5e7-4f64-1d91-08db7c9ea362
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:54:59.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K36LcWtv4W17wAcmuM4sZeTg4zmeqiIQy6bWAntOObtr/E6+agH4Y7UGCPozm+d6Bx+kKpeZnBJrk1gK0jBnBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_09,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=951
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040128
X-Proofpoint-ORIG-GUID: NY8qtBLLJU-GpQxVr4RNm4UcLBepjUsu
X-Proofpoint-GUID: NY8qtBLLJU-GpQxVr4RNm4UcLBepjUsu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 4, 2023, at 10:23 AM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 7/3/2023 5:07 PM, Jason Gunthorpe wrote:
>> On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>>> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>=20
>>>> On 6/29/2023 11:16 AM, Chuck Lever wrote:
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>> We would like to enable the use of siw on top of a VPN that is
>>>>> constructed and managed via a tun device. That hasn't worked up
>>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>>> no GID for the RDMA/core to look up.
>>>>> But it turns out that the egress device has already been picked for
>>>>> us -- no GID is necessary. addr_handler() just has to do the right
>>>>> thing with it.
>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>> ---
>>>>>  drivers/infiniband/core/cma.c |   15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/=
cma.c
>>>>> index 889b3e4ea980..07bb5ac4019d 100644
>>>>> --- a/drivers/infiniband/core/cma.c
>>>>> +++ b/drivers/infiniband/core/cma.c
>>>>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 =
port,
>>>>>   if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, p=
ort))
>>>>>   goto out;
>>>>>  + /* Linux iWARP devices have but one port */
>>>>=20
>>>> I don't believe this comment is correct, or necessary. In-tree drivers
>>>> exist for several multi-port iWARP devices, and the port bnumber passe=
d
>>>> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
>>>=20
>>> Then I must have misunderstood what Jason said about the reason
>>> for the rdma_protocol_iwarp() check. He said that we are able to
>>> do this kind of GID lookup because iWARP devices have only a
>>> single port.
>>>=20
>>> Jason?
>> I don't know alot about iwarp - tom does iwarp really have multiported
>> *struct ib_device* models? This is different from multiport hw.
>=20
> I don't see how the iWARP protocol impacts this, but I believe the
> cxgb4 provider implements multiport. It sets the ibdev.phys_port_cnt
> anyway. Perhaps this is incorrect.
>=20
>> If it is multiport how do the gid tables work across the ports?
>=20
> Again, not sure how to respond. iWARP doesn't express the gid as a
> protocol element. And the iw_cm really doesn't either, although it
> does implement a gid-type API I guess. That's local behavior though,
> not something that goes on the wire directly.
>=20
> Maybe I should ask... what does the "Linux iWARP devices have but one
> port" actually mean in the comment? Would the code below it not work
> if that were not the case? All I'm saying is that the comment seems
> to be unnecessary, and confusing.

It replaces a code comment you complained about in an earlier review
regarding the use of "if (rdma_protocol_iwarp())". As far as I
understand, /in Linux/ each iWARP endpoint gets its own ib_device
and that device has exactly one port.

So for example, a physical device that has two ports would appear
as two ib_devices each with a single port. Is that not how it
works? It's certainly possible I've misunderstood something.

Again, this is not about the protocol, it's about how Linux
implements it. I'm open to specific suggestions to improve the
comment, or I can remove it if the code is sufficiently clear.


--
Chuck Lever


