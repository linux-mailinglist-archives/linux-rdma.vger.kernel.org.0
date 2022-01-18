Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8729349250D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiARLiw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 06:38:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237631AbiARLiu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 06:38:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8bMgJ026265;
        Tue, 18 Jan 2022 11:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=fkB2mIf2Icqu63GG9spLR6q0pVf/k/7Xs7aIxQg/zWY=;
 b=qS7nIuKPBXXc4bve3St/5NLGLbiaOey6EYi+NmRYDGAz61lwONQb1bwspABIOERYEd5F
 CEnRwJ+qXfbhCUttUE+Y9DOKYtDgwPLxaTew+jgQu1hK2Z69TrYXBY2HE9k6GB8nKSDr
 ZAgy6KvTuOwyW4QXH4TNmfyWPVQ87XbKcOY/1TAy/VYHWyYs0fMEzXpRVibtTMXhr43j
 yfkFgPhHcDtrf8OYzFriavNLneBR7V3rIktashTkn3JzQZle0DQJvXC/f4jNNautj+kS
 jK/0SZLO1KNJN8FuQeqqVQEdNn9wpWEiU/yrhDNxL4iZiZN7CYyNN8EpC12MT86inzJt nw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnq02g7rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 11:38:43 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IBbVML005716;
        Tue, 18 Jan 2022 11:38:42 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3dknwbaj57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 11:38:42 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IBcfhf31719718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 11:38:41 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA92136059;
        Tue, 18 Jan 2022 11:38:41 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D99E313605E;
        Tue, 18 Jan 2022 11:38:40 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.252.215])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Jan 2022 11:38:40 +0000 (GMT)
Received: from m01ex004.gmx.ibm.com (10.148.53.60) by m01ex011.gmx.ibm.com
 (10.65.151.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 18 Jan
 2022 06:38:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (9.221.46.12) by
 m01ex004.gmx.ibm.com (10.148.53.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 18 Jan 2022 06:38:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5IshhIEmdv8Ee0uzBzuTo1KfZy/ci/Moi+ziyIK8/Rtl4g6g3zo8VqYe+nhfxLi3ykwcCmiLXFKLFMLUa+tTOgr0ziqPQ45EP3n249g/JKNGdlp5ovVO2q+Ukg//qf8cN0FUiG5S5gUqiE0eL9sHBtTnKWQhILvqUMo8ydx8p2pvoO7JVVkVki8iQaEtktkW7BLcsH0DD104sueRNjiSe3R2SSvGWqnaOmqXaNCfLtjvMH8zJMHZ2IV+SAFqHeebXNNW0wfw3iCQrfnDlGizARn/tIr5bSQxgpiAslpOjwaQ7jj9NIbN/BrmfRsSFSDiiV0tn8YBQITPKDZEY7Qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkB2mIf2Icqu63GG9spLR6q0pVf/k/7Xs7aIxQg/zWY=;
 b=YC+QIBGh0YJx9LN5aKqByJVv9lwRCgAdvSmR37N25ODFEgMvEuNHyFE1i02M+Jw4zPJOaeqbaCwhhCkrY5vAE6bfPANYLdX+5ClaJLol8d4f4KnqVL0a1BNDqLbhvVEzuwOx4/jNNmAtg/RfIC7phq2X+hxLH7wki3lA9cBBq6/V9aD+LdQJ9pA4LduG9nyFA+OdV4Hz8mfNcAWrwQ0CHJ8IleOBAzl6RV8vgR1L+L6P55h+fqfn0AvjNDPF6x3+ak041HST+Tuo4neMRg4aW4apDbgOUSYu1mfNYfRQuRwhzHGb9G7ZUBrSFvOiWf9mOkT9Wk5wIVK/DAFyN0rgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM5PR15MB1723.namprd15.prod.outlook.com (2603:10b6:4:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 11:38:38 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 11:38:38 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: fix refcounting leak in
 siw_create_qp()
Thread-Index: AQHYDEtrROxj0Da5xUu2WLRobCKjA6xoprgg
Date:   Tue, 18 Jan 2022 11:38:38 +0000
Message-ID: <BYAPR15MB2631A02D2F6F1BEDD83E573699589@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <20220118091104.GA11671@kili>
In-Reply-To: <20220118091104.GA11671@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 595a0455-f562-46c5-2cae-08d9da7711ab
x-ms-traffictypediagnostic: DM5PR15MB1723:EE_
x-microsoft-antispam-prvs: <DM5PR15MB1723485AFAA00800CF907F5A99589@DM5PR15MB1723.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFb3MunAYPj6sSsFT3nPXPad2zmEcJusqkKgy8hdZSiN919r6UAFLQ997/GEQSZZZ843c9Ap4XhSTtw5VAKtqMSYjQY64pUFprvTmWUJoatrvBJ+cMfnsIb7phywtwOFmbIho3fiNaC1zrROh/7flPT2hZuY4hDiZl6lpQzoMHHiOJq15WHKhYOwIpWVWdVkAmiKkUlx/82hCEgr+WkWCRlpSefnYBCpHi4pBXnFmzC5t65zX6RcpaKch7xK/WkFjT9egOagNHSUAVOjd8ZhqbxAxdIFVlwu726tWIYESQeRNITNqM3VE5BcpzEJ0+JVhRbs1DnvUkFkbRoMRjtYOs4E48zk7LzMXjEetUqX21kJDo6Msk8QIRjuHDsCm0q06IGu+zQ8JBsIRnMDV1zRwPMIWCWAuQmN/B4Ndk+V8gZjrUDWBVXQjSF5pBntkCIy3+ItfIKH/bi3Fo9Ic1pkVxKt/OibZqknipDxgsVm4cMvG3o/y5e5dxJpw3F3sO2VTLLtf1gIIRjCj0ipWXLDDtMajVSp9TqidmZfVH5IL1FmpeCj/jo61bK1opGCfUbhFEhyeCPe1+VeJ5ibPpEyg88ImcZ6+qV5AN1MJDA86VLnbjBuXO+UcJXnFC9v0F9VRTfGxHAbnw9e0BvhjQr2uwytx6FhvY5fi+gWft/niM7WK1w/pizFWxLKE9+uy6UOofp221Pm/nLN/BXhS/Fbiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(86362001)(66476007)(110136005)(66446008)(66556008)(38100700002)(52536014)(55016003)(33656002)(122000001)(38070700005)(71200400001)(54906003)(316002)(5660300002)(83380400001)(508600001)(9686003)(6506007)(53546011)(8676002)(2906002)(8936002)(64756008)(4326008)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzlCN0d5MzVKa3d6MVU1NHMyalhWb1hWTVRRRG9rckVNMjZlc1dMSDlMRklS?=
 =?utf-8?B?VGVITTIveXpyeitFanptbXM4NnlIS1Bkb1F0dk1ES2N4VjFMWnhKNnU0Nll0?=
 =?utf-8?B?ZnhqMmdvTWJmNnYzWUx3bXNwTG1FNzIwRTM1YWpjVTE1VUQ4K25tZ0J3NnZG?=
 =?utf-8?B?djIrcENZc0J5OWhaZG5qUWRqZTU5Qi9RRFVMeUV6VTEyU2dXMnErQ0ZtOWZj?=
 =?utf-8?B?VERkUXFPK1NnbVVoOE80TGNjMCtaemVSOHhoZkFReUxtTis5TFFYSjlDa0dh?=
 =?utf-8?B?c0pMWXNtbzRYejc5b1ozZmRZWTdiZkRlcThkOUdrZHpRVnZIQjBiL3FxR0JR?=
 =?utf-8?B?NmJ1K3VSR1oxSnJ6SjBpdzFOZTg3VjVNUzFDenBqUHNZcDZ6d0xLOEFiSit2?=
 =?utf-8?B?c3FibitZazY0SjFoaU9mVCtBekF5UnozcWtKbWhOaEtuWS9haUwwa1EyejZL?=
 =?utf-8?B?dGUyYWtyTkpDbHJ6N1N3YTJuUzE4UTU2R3Y4c1NvTFk0dHhhYzdOTkJYeXBG?=
 =?utf-8?B?RGNOeU5ieGFHZ09PYW4xRVl0Mmdwa0FXby9jTGN4ZHpoM3ZBKzZKZlNKcll2?=
 =?utf-8?B?SlE2Z2VCNWxtWU1BWWNEay9tYWtSajdKaWwwWHZSS2wySGJMMUdtMTJjekwy?=
 =?utf-8?B?SlprSWQzbXNhUUpYVXdlc1pVc29VMVhDT0F6SkZpMGs1Z0NlNUtCRGhSOE5s?=
 =?utf-8?B?TTRCVVF5TVI5YVZ1d1lxd21SUytEb3RSbHJNZ3hGQUVQZ2FqSFJ4OTAyN0Yy?=
 =?utf-8?B?NnhKRGNWbEMxbFhZbnVwbnlKNTRDODF6WXJORDBEVlFzakMydUFVaU5vb01i?=
 =?utf-8?B?UGg4aXd4Yi9UWkUyT3JpQ2pvOTJNbzJERFpoU1lZMVk5bEJDVkYxcTVIRVkz?=
 =?utf-8?B?d1F1YVRZOU5VOStXdjhBeGhUMG05aENtSzFZWjBZcU8rZkVrME5aN0VuVDVs?=
 =?utf-8?B?OE1LeHYwbUJpZENxenY3eTNnQjNweHg3cFduSlFOSlQwV2pGTlIyTVBhT0dp?=
 =?utf-8?B?bG9SdWFxeGdoYjRxSFQrQkpJR0lZai9VTnZWbjFYcVJwck9XM0V3SjlVaXRq?=
 =?utf-8?B?andZODB5MUkvYjJYMjBGOEtlTjF3VkV5eWhGdUdoMktUQVl0Ly9IVEtvejZl?=
 =?utf-8?B?K0UrNFJYemhLZWUrejVBRXFFUEx6RU84MEdPUDFUMS9VZFFwbWNIR09SRTBL?=
 =?utf-8?B?azhjY0IrdHhKa1hlQThVbU5ocmovZHdHRHFtelgwbmNaMjNLWTFFM2E5STVz?=
 =?utf-8?B?ZGtBV3lKTGswQjlFQWtGV0VjQTg2S1pKZDFLUURocEpzbkZjakFreVZKSlpK?=
 =?utf-8?B?aHp6YjUrTVU4RFBGWlMyN0lFaUhOTUFJbUZCM0xVcTFNM2FsRDRiNlRaR3pu?=
 =?utf-8?B?WHYwSkx1VzRtMFJwd3plTEZsa29RQ3NDNVBQcHpFTCtWUFhlcFRoMU1RdDFC?=
 =?utf-8?B?d29DZ01qWHo5aHVEeDlYY05aN3JVcWFZeEJaWXozQWFmT2NYeGY5S1AxZWRl?=
 =?utf-8?B?R2grOEdtRWtuQTJQc1duempTZWQ1Vkd6VGpTaUEyS3I5eXF2K2k3enhGMHhh?=
 =?utf-8?B?R3BHZ0xyN1RWWkJLK2Vzem8ycFlVekk2a3BXZlplSEdiTTZaOXUvQ21aN01V?=
 =?utf-8?B?a2U1NW5mOGFuQzkySzRkN0VLZ29UclV6L0tON09wM2VRTHNGUkxHeUFpVmdH?=
 =?utf-8?B?ZzVqYXcwNDVOeURnSW55Qk1wMmRGWDRwam41eXgzSU5ZUHZWTmxleVNRMDNj?=
 =?utf-8?B?YkNsSitGYUVzK3hGVHJvUDNCWWFxaDJ1OE5jR0FjMUFKdVFOdzFjRWoxR244?=
 =?utf-8?B?ZGxuWTdFVUdXcDNzMXhVV2ZoWGp6YVV5NkY4OE03U0lxZEpMVi92c1N1QXNS?=
 =?utf-8?B?SnRQcmN0NnNhdXhwWkFHM295ZUh0c2RPOXBzQi9RRlhqZFdwdkVwVHg4eHVH?=
 =?utf-8?B?dlQ3akMwaktyTDFBcFR5amFMM0QrZGRZaE1KSEJzVGdNSjdJWnp3dzZvK2tO?=
 =?utf-8?B?VXlMaFlQUTc2RzBmN0c2M3lQMThkRGFBSWJ5amEvNmpXZk1NM3V0UEpDVU1i?=
 =?utf-8?B?blBlTG5lT2NlWXZuMjRzVEc3UUY2alhlTEk5bHl1UHZmT2pDRjdCdEU1dnNm?=
 =?utf-8?B?NVBVRTE2MjVPcUgzQVRFc1hueUQ4L3pJeWhycTZiRzh5NGx5OHRndkp6K281?=
 =?utf-8?B?QkxNTWVxMUd0eWQrdWVEN29Demx4Slg2NFlFNFpmZ2F1Y2pXVU8zYnliRWty?=
 =?utf-8?Q?7CgojBcdV16PdZVhIkcJBR8RobecZ+K+qPH9nm4x/Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595a0455-f562-46c5-2cae-08d9da7711ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 11:38:38.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKNw+fAV96MevXc4erGKwDR2Sp3jkB1/FGJIrhXp2YtuSkeUb5IBPAHhxS4r7Bqa3Zu456sNAISUj9QiiSqu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1723
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NDnj4KaqjPvPB1PCA8EcWqYlu04wqSZv
X-Proofpoint-GUID: NDnj4KaqjPvPB1PCA8EcWqYlu04wqSZv
Subject: RE:  [PATCH] RDMA/siw: fix refcounting leak in siw_create_qp()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_03,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180070
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDE4IEphbnVhcnkgMjAyMiAx
MDoxMQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBMZW9uIFJv
bWFub3Zza3kNCj4gPGxlb25yb0BudmlkaWEuY29tPg0KPiBDYzogSmFzb24gR3VudGhvcnBlIDxq
Z2dAemllcGUuY2E+OyBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+Ow0KPiBEZW5u
aXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT47
IGxpbnV4LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZzsga2VybmVsLWphbml0b3JzQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSF0gUkRNQS9zaXc6IGZpeCByZWZj
b3VudGluZyBsZWFrIGluDQo+IHNpd19jcmVhdGVfcXAoKQ0KPiANCj4gVGhlIGF0b21pY19pbmMo
KSBuZWVkcyB0byBiZSBwYWlyZWQgd2l0aCBhbiBhdG9taWNfZGVjKCkgb24gdGhlIGVycm9yDQo+
IHBhdGguDQo+IA0KPiBGaXhlczogNTE0YWVlNjYwZGY0ICgiUkRNQTogR2xvYmFsbHkgYWxsb2Nh
dGUgYW5kIHJlbGVhc2UgUVAgbWVtb3J5IikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d192ZXJicy5jDQo+IGluZGV4IGEzZGQyY2I2ZDVjOS4uNTRlZjM2N2IwNzRhIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTMxMyw3ICszMTMsOCBAQCBp
bnQgc2l3X2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsIHN0cnVjdA0KPiBpYl9xcF9pbml0
X2F0dHIgKmF0dHJzLA0KPiANCj4gIAlpZiAoYXRvbWljX2luY19yZXR1cm4oJnNkZXYtPm51bV9x
cCkgPiBTSVdfTUFYX1FQKSB7DQo+ICAJCXNpd19kYmcoYmFzZV9kZXYsICJ0b28gbWFueSBRUCdz
XG4iKTsNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ICsJCXJ2ID0gLUVOT01FTTsNCj4gKwkJZ290
byBlcnJfYXRvbWljOw0KPiAgCX0NCj4gIAlpZiAoYXR0cnMtPnFwX3R5cGUgIT0gSUJfUVBUX1JD
KSB7DQo+ICAJCXNpd19kYmcoYmFzZV9kZXYsICJvbmx5IFJDIFFQJ3Mgc3VwcG9ydGVkXG4iKTsN
Cj4gLS0NCj4gMi4yMC4xDQoNCkdvb2QgY2F0Y2gsIHRoYW5rIHlvdSENCg0KUmV2aWV3ZWQtYnk6
IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K
