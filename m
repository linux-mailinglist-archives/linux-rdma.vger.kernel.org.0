Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F607098F2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjESOGa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjESOG3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 10:06:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD0114
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 07:06:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCinNE009347;
        Fri, 19 May 2023 14:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7cMVFcj078qhBwedbb3da76ZIpYozEm8xbFAsUNH03k=;
 b=MmQqW2MEvpvKzF1rlBrigbNBngBySjaBQAJw/gvXlOxun2/Y8jU2KBMN/CJxLLELnCpA
 asXq9iA+C/G9e2KmTpV8CcBQD0ikKkymNmW6B5CYHUq0eT7E9mDNck1Qmlq7RQNAHBUa
 4FQvbJ8qu7JHjPa8tk12VvFmwdMwV09vLH4jlqbvZeFrjvJXRVlzrSEMelDaauwlfQoh
 445sOgzTlZfTG9QWwjKIiAQfWwgs7Pmf3bsQTDK5XQGwgYW+RKUhtRaXBTuJ8IvkNhWH
 pGrNIinp+AgIYem0rhzt6Ho9tHNWBo3hHM5WHyQFMt7QUq1H23GOCiebg55tMlsJP0HY eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkuxaenk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 14:05:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCAR54033921;
        Fri, 19 May 2023 14:05:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj108ky2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 14:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi8s8f/PWASCE8WJuEnbZ2N9Il/Qa6Ox/MutDbzKvnhLKvfqlUX3R+uNEkajk91A9Wyn6AmNvpJxkR7JyEi5P13lBqUYn2N3nIGl0GwWWek6Hi/Y2AtdP2iLrPV/LGK+vpZwlVB1d4MfTYobtWfl377UG4JRgV0it+XUoMYLCMXaLu4KYMl/iiCmRfEWWp5Y++QeN5h9PN8NTElVqHbianFLoek2ZRGBiswj8+I4Vpcn3EbNHv17YWVtFdrpWkoORD63XQszIBMPgekqsFLXRXrlxuBP6s+AB0LnC9e/lXpAakHQswf0kuNXuCumJx+9e+0w/RXMzfJXT8ZCSx8CWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cMVFcj078qhBwedbb3da76ZIpYozEm8xbFAsUNH03k=;
 b=D0ovdCnTe8x/iuj6uSvVCeYW9V1Yym+6GSSHigafGmuN9MeGu5YRnbvKqeYtz7zFCV0umv76q+eyJWFqHR7wMbSLTcEj+kwr6Sk9ub9YnGJPHQS32BJ4lc0mX8LOMsGlfZBhIHIngvK54dI5s+VbHv0ntUMBJ/RpxY+fzSEXxuHtGPZOmUbzvzaWd5hn+2roWKLa9RbwaKu8LYsC0mT4AiUfSaZ3iABAHwNdptowtBGF6+RR9HH5HHbVBdgPGH7xLel6xT1G3Wbfet5y188xrYRUruDEzzH6ZkkqzxIeqB/vg6XsppznFC4xZRT3o619lhruCA/00/Y841LCU2tK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cMVFcj078qhBwedbb3da76ZIpYozEm8xbFAsUNH03k=;
 b=nYBq9Ws9KwvTKwqxyzLe0rguh8I9fJtUg+RUgCJx81Q10uOP1A4hYaMyIgbR4/PERDsVOnohCVoYsDLy0pTPZp/wGi5AJOZ6EBM2Y4ExCAaV5BTU5pj+yPMaq3qyZFFo9xU22lrY7XTR9vahisqBsaq3/bKslc7UUeHAmWtvHnE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5251.namprd10.prod.outlook.com (2603:10b6:208:332::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 14:05:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 14:05:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "pchelkin@ispras.ru" <pchelkin@ispras.ru>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Call dev_put after query_port in
 iw_query_port
Thread-Topic: [PATCH for-rc] RDMA/core: Call dev_put after query_port in
 iw_query_port
Thread-Index: AQHZif+i4YvdNZFRukqLJXVYTQdjNq9hoV0AgAAAmwA=
Date:   Fri, 19 May 2023 14:05:46 +0000
Message-ID: <3B612246-D6B1-4977-B254-B2AC437BDC1A@oracle.com>
References: <20230519031119.30103-1-guoqing.jiang@linux.dev>
 <ZGeBrhW2S5ukL6PS@ziepe.ca>
In-Reply-To: <ZGeBrhW2S5ukL6PS@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5251:EE_
x-ms-office365-filtering-correlation-id: 9bcbe772-796d-4c19-7eb6-08db587224c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JucKgD5+UGdGXY27M2d1vhVDtypyfer85ukARkp+OfG/E7Z9H4/vZAyxKMgCVsr3rdhsz6y+u4Pf7B3IYdggza9s/Z2SLtjAl+KL8iZ1YPKwseEUKTm6v1PLqM/YXpg2E1Zl5YDZ9qQjAdJbaEPVWUBwb+e3lcYmvq/Y62s6t77DkOpaQdtdGt6VzlVDPCp5Kp1w3C2aMMnQ0pU/zTbe3uB//f/rCNjK8DxH6YiKfDKx1v8LENcDiWDDYkxCtSUD/5ID4vm/od0rOmM0RKr/fFDboWO3jsQjf1LU++tLmpP0N6Ez8/n2Au9w5WlrpX7/7sC5Pk8TupwVt6QhVtc0uDMn0cvd+uRYmIQ8TXfujF5FihOaVDFKzpVd+1zYF4frD5wcrHAuJvPeLr/fjT59OoVUCnZwkaZmHW/A3BTzW4xe3MgbhFg22LCoS8/3lNQq7CQVTwX63djFMjl51AEw8bJVueULq84HOk05xvlVBBlAEBCebg71yPxJofJLmq12QNza0vyEaWWsfKYVCJlwmChq2HB6Sn+e8lUg32XigalR5ZkKfn2LK0KpRkGYNIVJXXTN3Z0+afisVkeUj2QqVBnSM1Yv0hjOSlM5Qz9mep0062L1tFZplR//oTjgzzN+i/zOrL+wpTJjDkzjsskyhQ+isxzNMwOH+o4CW6vXLgsk1VkqJnWayYkLPtSmTPmL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(53546011)(6506007)(6512007)(2616005)(8676002)(8936002)(26005)(36756003)(33656002)(86362001)(2906002)(83380400001)(966005)(91956017)(6916009)(64756008)(66476007)(478600001)(41300700001)(66446008)(66556008)(5660300002)(186003)(316002)(76116006)(66946007)(54906003)(122000001)(4326008)(38100700002)(38070700005)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fMdJmXaKx9V4bMEeLlGbYpsETGZgdu3w5KK6L0HAuaD7A3AZOrssJ9Ef+ur8?=
 =?us-ascii?Q?ONCJhhMF3jU59vs2xX8NOJZ8vjfPx/mvQMVkFnb4ceOXA+2JH1qyW4EJaK26?=
 =?us-ascii?Q?M7YzX3X3mu7uI66iFTGt3cmyNCsATm8EvTfJ8Z/rmwSKgjiB+VGb3J+x1wew?=
 =?us-ascii?Q?mtxD+w32OyXDHBr1V5N2tuve7MYN90j2Qgs6f7bDnWchMpJ3VFWXJ2Xx/beR?=
 =?us-ascii?Q?k9gV/2nu8HNWg4Sbc4ZxQr9fP7DorqOeduU3wyyg39UH20GlZ0PQQt8y+HJu?=
 =?us-ascii?Q?+8q8m1stAN6m/JWEk9vgxB/6NTWVXibifO09uwfh11imtksNOAksl++Vu7ae?=
 =?us-ascii?Q?J1pzP6pX5pBbS0HOSCOhziz2zYSIgXoWgUk71uR0WghMy0vQFgxRJfjFn0lr?=
 =?us-ascii?Q?8+27UlpPevKcdOhQ1kSJkK8dLA+pnsCHiCR0zGEvV9qTBsDm+yb9vZSYINea?=
 =?us-ascii?Q?mMxCYqwKKo1GJ3DAEfMIBf3fBshp/MceKvKGgpMvk6sbnEdQH4rxBqsO7V1Y?=
 =?us-ascii?Q?JL/TuX5RuULl6CeZYf3rf1Xup8mMOCBrfcIXXFKdAJjoKKoVb0zdUrSBl18q?=
 =?us-ascii?Q?h29rLZGGbfXi0nj7BHEjlkrRhXcYNCQUaP3itWZaUieFCTwgk6/QZKdTEg7F?=
 =?us-ascii?Q?mmL7rzSJZEu0UkX1X+CixQ5lTqBv2qu0WGOnWp/oLZbOFRDCWcX3AnbVAK3j?=
 =?us-ascii?Q?GHQEhHVXA9tCFDnnSL/uN7XOftoeA0OmcxkHqSP/cTvIVEBMrRNFjD6ZGgPY?=
 =?us-ascii?Q?Z7pSsb5Xzlp5twviGPyG0PPeeYy9kBqOjuWpjvRXTfg6B5dcrKOXSA58MGCQ?=
 =?us-ascii?Q?RR9uA7BpCUeA/w+/Zmla8/cBUkm2R4NM4k5pOABVTBsYBcZ+jOG8bddIJVhC?=
 =?us-ascii?Q?t9LQwlbpWXb5uxyZleskhUudPrGZijis8G/MSotmr1Ajcye14a8t1JWsvQkw?=
 =?us-ascii?Q?F1VL9M2QwNCLSoE/e4NsHZk5Bv8orpe2rUyTOiW3cEE9tW/MJR4TNnUonBVh?=
 =?us-ascii?Q?HgKoU/E57QdSiBIWRmTx5Y8VVNqOqea4sFoPf9HYhDCFaSpUaHhqYVFvwOVE?=
 =?us-ascii?Q?iV3zu9kQlxdKcPRDZjCeELn8zjASM7A0qBsQkygRU8MLqL+5jj/yYDYcUBUN?=
 =?us-ascii?Q?t84cRmWQrbHVvjE7iyBX1VwZhjlTylpM/D2bF7Ow4iGbqUfjABudtmnEA3FI?=
 =?us-ascii?Q?rFqyF0/ZDfq44F9ImG2Nm/71WHdLYUN3iAIlUJCDRkVUc8NLyj6RDbQdkSxO?=
 =?us-ascii?Q?yDAwd2xSgWzeH3Q11pgmPgtyyj3ithBp3q+o4ZDlaW9u6GWIqy0YX1OPEHPP?=
 =?us-ascii?Q?rzgXQoKhiAbKXmbw6vEO8Z+cGE5ApMZ8y2QO5PDoYWSrstaAtWAba/DvT2Iu?=
 =?us-ascii?Q?Lhn1h3bt53rsb3HNW9GZ1sc454h5wGuTm9MRCzPllXcRX/+XiRRn9ITfZCdc?=
 =?us-ascii?Q?26+BhoG3f/QxwF/nvhq8OrmNKTtzVVUz7J4NjEfdBDK04F7bZ5RRFed8luBo?=
 =?us-ascii?Q?uBbVNKwAY2HN4BrdbZ73xeJC+6XPS4K0N2FFauQ+sEiDVZYe0Wo81m8hQlQ/?=
 =?us-ascii?Q?Jlo57ah8J9fMOn7hMlPmY5J35ms/c6qNrMI7jQ4miyzPqxZAB2YwfPFPJNIm?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6A942B8B7A4654CB52B24C335373DCF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b7drV8fNnTGCBqp2uE63WejPsh3oj7Qmuc8wM7LdJG/TtKmUiznuMAeu0eynflEfbZ/S+Gyg3UPDBvferz+aNvIrVNYGWtOIV1NrW+TnLd2dqSBbUf8+m9mkgjvbChlYcQN5dJPQdrnAQVEGHFDOGcRfIH5sVSw4IAVPupq/FFSaYQCpACu9RXwXCa9tTjP9ecnFj65QfsJ0M3Q7BveVmfpjfwdfMDyPma8Jm+14JfrAFqjvUF8GFpdR1V/bQeK3dKDnpar6y1ur2BRCmWMPHuy32qTM864H3hWRi1NTWCQYFci+ABy2/oaxuMs5JnAfPvjwBi9lmIeKlQWsL5/fZRNCY/f94Jf/F3YsvyaiGqEJenI9wqBsTpwJ4oE68+/KAGypHLjBFaHiKi1e73Smpnb8UOLP3iDwkfcHd0g8kPyvotTwAh0NKnCO4RrYFdHyRmx4ootsFL0YD7NFIH7mgzyz+jd7XBPoG8LVyP18BOyqMOpuBcBxIN56DhhKnYoLbmAwhKH+n2hcPtfel0HLB1jPYA2udAyqqMS7mB6YvX+1gyNUulCp7EfqR+SrXDqyYd2pwhb/7FNUIUNzW10j9qLtl+BocvrrdYmDSqAz4KLgyTm1hOL/GT+ouacBFRfqJOB0Uqjy1Y8b6WYxjICl5gbKHq0lRrAoq1DcBiLjQ8X+rDynNLq9Oe0PAPRkzx6c+ETw5he7OrtJFM2TlpDePr90D5aP1irWMySilpr5yqEJiFp7xSpV7A+5d8OWI7cjqUGBS0/3wYr/ki7+alVCRVZcOgwStCCZw0Y/aL0IqlzBNK3gOcvUA0GivMBySEsERGa9AFAg9rLFzZC+UZGTYQbEYNyTReYpIGh/Pi6zP5o1WN+KdxHkiIJaBXkkr1CU8d0LPbVQIHfTPjoSGzUMuiEIqydSAiAvj9/RxbPZ1oo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcbe772-796d-4c19-7eb6-08db587224c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 14:05:46.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/v/yCBMT+D3U5ibzuGVuG+xqonov773aRBVGuQQrU3EAAE/EMu7RSUiRTQGeUi5wLgSU0OpIYxCTNS6bU81rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190119
X-Proofpoint-ORIG-GUID: ono30lq9wGlCjmBS7NTr1w6MK0538QKI
X-Proofpoint-GUID: ono30lq9wGlCjmBS7NTr1w6MK0538QKI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On May 19, 2023, at 10:03 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Fri, May 19, 2023 at 11:11:19AM +0800, Guoqing Jiang wrote:
>> There is a UAF report by syzbot.
>>=20
>> BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/in=
finiband/sw/siw/siw_verbs.c:177
>> Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211
>>=20
>> CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-0001=
2-g16a8829130ca #0
>> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google =
04/14/2023
>> Workqueue: infiniband ib_cache_event_task
>> Call Trace:
>> <TASK>
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>> print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>> print_report mm/kasan/report.c:462 [inline]
>> kasan_report+0x11c/0x130 mm/kasan/report.c:572
>> siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
>> iw_query_port drivers/infiniband/core/device.c:2049 [inline]
>> ib_query_port drivers/infiniband/core/device.c:2090 [inline]
>> ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
>> ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
>> ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
>> ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
>> process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>> worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>> kthread+0x344/0x440 kernel/kthread.c:379
>> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>> </TASK>
>>=20
>> It happened because netdev could be freed if the last reference
>> is released, but drivers still dereference netdev in query_port.
>> So let's guard query_port with dev_hold and dev_put.
>>=20
>> Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/lkml/0000000000001f992805fb79ce97@google=
.com/
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>> I guess another option could be call ib_device_get_netdev to get
>> netdev in siw_query_port instead of dereference netdev directly.=20
>> If so, then other drivers (irdma_query_port and ocrdma_query_port)
>> may need to make relevant change as well.
>=20
> Something is wrong in siw if it is UAF'ing it's own memory:
>=20
> attr->max_mtu =3D ib_mtu_int_to_enum(sdev->netdev->mtu);
>=20
> It needs to protect sedv->netdev somehow on its own.

Note that netdev is actually the underlying device. An siw device
doesn't have its own. But maybe it should.

--
Chuck Lever


