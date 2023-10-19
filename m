Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140847D00DD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjJSRtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbjJSRts (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 13:49:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4711D
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 10:49:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGDu5E019754;
        Thu, 19 Oct 2023 17:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=STJkREwQU5Azpux098T0xlwWhDbiRae4yb6Vh5hJUQI=;
 b=notP3ZmhRVtaynEZFgVglem4qfG3DdCwaTZM7A2ERfp/B1v2mE2O2STrW0raVkdtxwzk
 URQgMCsbvf2DXVHhAUx8zj1Q4zp6OIwcnQ+RkyrJKoUVcsmo2R0UlvkfUGBSanC1pO2Y
 2dNyeb3DGDr7P4eTWVT+Zqa9cqNEAMQ6TwOl3/Qn95inax3On5XJBtLB0r8u17e93xlV
 aCcpbQVA6wsJA2o26/0E5YSNhgM1KIlLQdxJ1j7ySPe+FO6u355x12jtNuXz2PvQ6YKc
 9RLYlzjvZ1bCrYBvTi0unMEyGXz9mP+KjaelEF9rhJL8mg26BejLZpyXvbcHiW7Y8V1i Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28uer3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 17:49:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGXcS3009572;
        Thu, 19 Oct 2023 17:48:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0r1khb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 17:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+aSwFOkC/HPEpH2iDV0f876GzNy6WmI5rh3zK1ERPrlMU1easZd+thldYncqyS9joQC1GRkyOP05aD9S6oGiA8U1BpObedYUAWOqZYozgFEwjSF5/vUIWAtaBr1qmTdjoVb61vFHOZLYDZ4f/1kGovXYH8Dcg4azpmKzptZxEKbaFgnJdqgYPrZOveeKxhAnBq9Vitb5YcIYSPQwwifsa+2TWEUuj+SA/YBDtQMZrwbXX6vKYJrTDJz6tQ16UZgjVtigUTDRsoRdIzDycVGOh6//YQ+E2eG2voZWY6fItRO9ZmWhbb8NzmrehkMOGkd34qyR6pJNkEmtXEL72GtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STJkREwQU5Azpux098T0xlwWhDbiRae4yb6Vh5hJUQI=;
 b=BrtRRcVmUsQqbtOwBGiuUmStsPsFG+bE6QSgYmB+vF2lP+rmaZxQc9nf1oCySyiTifSoIqsFGL9V6QIvuAn5FtaFQ23Exmbb4nnGnYm+niYZgEfzATn53K/T/g6BcvjF0bhOdxD8QgQgXipVcCOa8D+PYm/fTOIea1SJyX+7NZkfa1jlGU5DKgYhU5T6Lviclsocerp+MhZxg22hIKN+RwvxOJRRm1wLzRO/yWr+8ljf+mqVSLUELjis0rZu/uDm2kdpz4biMQTsgDCytaAJqWhYHUSGoP98V1SXeXxZsxH9ULWi/ploxjMu8wyQuU6Xq6TuyLYWlj/P8oflvxjBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STJkREwQU5Azpux098T0xlwWhDbiRae4yb6Vh5hJUQI=;
 b=TDvHNFHJe7fx/7YlCxeEz7cfqIPKnjxNNHzPR3ncx4kWMiGLw6DVl4JmoL/EU5Z3dJ14+r8wYF6MSdSJTDLgG+X28P4geFuAX0FcxyNUX8mcHsrSvrx3iv4dQqf/BJnzlWXtsr80DgetqKkNvrRf0EQW2xacuuLgTCCpzvYX2xw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7857.namprd10.prod.outlook.com (2603:10b6:a03:56f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 17:48:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 17:48:55 +0000
Date:   Thu, 19 Oct 2023 13:48:52 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chuck Lever <cel@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
        iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <ZTFsBG+WebEDqJMl@tissot.1015granger.net>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
 <ZTFRBxVFQIjtQEsP@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFRBxVFQIjtQEsP@casper.infradead.org>
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6232df8b-8bb3-4f40-039d-08dbd0cba9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFg/XjCy6sWCZCYhEi6pt3ye2Vc+CYRqG7kAnGYL/eqqukvbPSY7kbmdXkcKJQAcWCP7UR0hFz+UCAGnDD+5CI03P46ZYZEBUxlANGxbbgVHbPjloTFRHEKUnIAev2XeO4IlL373Cp5FvHrK1dvd+mJZR8o/Z43mwfCEQBAPNpvFP7OosZrDH6vbhVSJh6IIODnY4NBKGjvn5fQu8uhGqKLJmbzGCFNX6K8CLfxTwtC65bBXuOKnkJqpCYHEOeCNsWODOqjpH7zeylfmHgqhOY6GoCK9ssrmx22ujlDT779Wvvj1dIzWH/CR2x0cAnComkIS0ZiKaQamhppDNTgOoEdQirO42YLxtFLdowKrvIb+HS9Z5Wu5Kg97XptkzT9P7mvrlu0ODgmWoXn3qBjSkUSRg7KO1ZXjPNMwhcof0uY9npmyFdS2k2YXh4aMyvz+QsBOxGlKSwBPtdDPBkCA8ErQjJcI8v2nNIrE3vOJkmc+Tcq+wZdsNJGv4Cq1E/7lIokQmKMTKK1a1UF/96MsYUo+rjTXVYuNOK689VSiGTcRAWxCnRUwTvCHOVl0pXVnFbBRQAh566T2cNql4dKO/67jAdDLgvH4EeWlU9G+HKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(54906003)(66476007)(6666004)(478600001)(66556008)(66946007)(6916009)(6486002)(6506007)(41300700001)(26005)(6512007)(9686003)(316002)(7416002)(5660300002)(4326008)(8936002)(8676002)(2906002)(44832011)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85nkG2i7p26q+Z6dzitOTc/iQwaHcTP58IwaTYLNjq7+qC/FhaBdzxp6/zGr?=
 =?us-ascii?Q?Sa3ZSI5cGDgWFqaEjew4hHh6pJP5Hp8mqts5mXZSRbNG3TQWqmlZKeOEobiT?=
 =?us-ascii?Q?YBf2k+FzwwX1+mekDzzsnofym+bCwPEUH8T48OkL8kvDT7/o5uZC/oWRRzun?=
 =?us-ascii?Q?1KVu+kxeL5LKPhMvicduXJupQMLbZcN3OGb85UreSe20TgsrWNrWNdIy2xIe?=
 =?us-ascii?Q?Wk8qzZgSDToSVJ2vU5mOcskFTfqXXJhKpRXofMLOkVjjBQ0lOtNUvaldC+f8?=
 =?us-ascii?Q?0/f2mAEfEJW8aS36TZIAEkzQQcsoJQ+TAWEpKH7vPQ2HHGKjW6Y4ClnghDmW?=
 =?us-ascii?Q?nP6QuH//PHAROUAH/p+WSlT0IXqwGHxjkTt+UK3wOmvv6DxrNCSstjjYLODb?=
 =?us-ascii?Q?ED9XlZNTnHL51ocqAkNAzYOPeqG/5B2S8ldCD9+QuyhKT4NiaO+RPvCRF0Za?=
 =?us-ascii?Q?U1CQS2aW0j415VybnSF4lT5SXOg0XzMsibHOCxOUniWCbmiYGG8HAG8Er5Rp?=
 =?us-ascii?Q?C6BID1/rKBQgTxzSmcH3VOguadKGpjnPAZcxlrGqyrkr5TNl9wlV0nB7BR1/?=
 =?us-ascii?Q?MKnrfKe6kSydIXWPGrC5S6ILsk23JqEOqcnKn62KSP+xDfL299EEJRSXbqcF?=
 =?us-ascii?Q?hh8FGjOVDTzUwU7wF8s9uXyNbtGuEWkTHBR45ahM8WHNKDadlRxNBXWLi/+R?=
 =?us-ascii?Q?13QO5bKPj5m5ScWXsm81mZJ1aU1GvpwWMi5edKqWJPqqMvbjJCNJwokwjIj7?=
 =?us-ascii?Q?8OTdLx0LQCZdkhmSB3aVjLswspgoVYctA/nvn1UyRv+zHZdf4j8FTvoqrIlB?=
 =?us-ascii?Q?e67ILguLCoAWOlaFabAoCfTMcTbDuerkx8KOI6fEfJjfDNBdyfajYfq4l3Vg?=
 =?us-ascii?Q?6EUJbFBV1uTAz0cJ5n2QtpCub30Y9NjqgAkIXsfiSCuYsYW+kYhy4MLxcxY2?=
 =?us-ascii?Q?0GFeLUya/0zKVtsip7l3OBbIvLimgjIzolVY92sO0+2xheiRTpjGS/E3/Oh5?=
 =?us-ascii?Q?xoJ3Wbb0s8oq7C4jAy2NGPXWKqzJvmENfn4xtS9EkRhmNwvnIHs9I4QkTZtQ?=
 =?us-ascii?Q?kSI56YPWrqPG2iel9SR+wt7WGqqjI6em2LJD3ew5LKIkXKLyfhJ+cbg4NJMF?=
 =?us-ascii?Q?+V1akaF+bi6brmoDplznB0ditBvWA5u+w/AZqUpbYkhe1yyYXRhN4YLqFU4H?=
 =?us-ascii?Q?iLC+k8g6VxrM4xg4xX1mgvK3tgdUEuXKohtnt6N51p/vrXMWStf4dzFhsSOe?=
 =?us-ascii?Q?M6OHewBJSw8Rj0oZqSPpHbLZb8GynsWjEGOEJn5NuSP6caHr2GDsIyQXJt0u?=
 =?us-ascii?Q?s0aHOO7qzdEpmqagoaS34dXV0fHSWmbUU0Un/YFNxLUZK2/NocBjlbez5TfV?=
 =?us-ascii?Q?VIgWiMkWrzamjbRmRqhVof4sTBYGoMBZws8hL+J4OFe0KG5pItadZub/o4Ol?=
 =?us-ascii?Q?VD7WINadKXIOvIjhbVlL/f3QMsQwnB8YtjdV3JsGahQtV+9raFzv7bKfhTzN?=
 =?us-ascii?Q?f2+oW1Wgsq6TgQiEcFMRd0WCC9TH5OvEgl6s2hoa9mO5Oyca0rmkilEOP9DQ?=
 =?us-ascii?Q?kKayHmAtrTCXMAe8RJPiHu1vQVtYvUZuXycXjg8rLshcDyeG8MfWHM5dri6Q?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wRKBI0g30SlLYYFzf6kY6VcCExyhqRG97s3TRnTAvZQC71ks7P+tFcQdH/e2?=
 =?us-ascii?Q?kgTLkkNFMT5NwvfsOXLe3c+inS7lzkzNzKF6I+8+xTD8FIa/FUqtZ4KC8UdJ?=
 =?us-ascii?Q?eDXxzD/R5c44Iws/EkytKRqPvDhKmRFpY6KR2MzPyQVmW58k4BlOqXsCrMEP?=
 =?us-ascii?Q?ZfQzY+N4CtILW8HWLFG+IPRuMdKirE2HuR4sa14p+t7h47b1Y3C0bHzVn6hr?=
 =?us-ascii?Q?CR58eFeGU/tH7IEzmWs0obePJnaHE2K0sZdpELgcksNnoTHqQXfBVCUEOIw3?=
 =?us-ascii?Q?IVWm3cSJ4wBppiq74eNGVJK4Fz0IKC8sowNS2OhYZPDN21luUphSQwd5si6A?=
 =?us-ascii?Q?EIAH3n8o0vp2wt5AKhCy4zTk63RqKuzAxlUq307QX6fPa1f8nuuaXt6byb8C?=
 =?us-ascii?Q?gAfhmLWyHMCKWKNkSBvC23fQ8NdqWuLKANb3rlV2Rs4Ic3Xb7DXpRNU1oJu9?=
 =?us-ascii?Q?4zJMUbVbLG6BMagkUalkAIrOjyM3abn3qa8qBRwNIS2C/XJPTqeXOZ65nOZK?=
 =?us-ascii?Q?QSilpPBC5DjZ/MfYRpOV+riYG/HhbrTpw8H6MU2c76+NzQazcAFogXuJmfjN?=
 =?us-ascii?Q?XiQmGSlMr/dWPTb33yuwumrR1eZzKc8XpBXs5KpVXpRE67u1ZL9YeiX1T8PI?=
 =?us-ascii?Q?VmG3uvoXvIZYBVekg3enuaOpg1UvWhFs40vSR7FU8ol9KaqvKEzAgFbHA0Ge?=
 =?us-ascii?Q?SbjsEIOOj72fmaibNpXb4lQl7uNzZCJQpOlnZ2BIUJYwQZQpYZuMMRm9Joec?=
 =?us-ascii?Q?eV5iEwrceeAU3zEqm95GR9I665LCjxkEIX6O86VgdCYzjp1hk8f018RRGaTj?=
 =?us-ascii?Q?f3J7gO8kLSuzBCWO9QvAvRWxePS6mrGiJFA7PZQyZ0QmZcBB2PznmdtYeKvc?=
 =?us-ascii?Q?lK6UOFDL0z7IFyIg7ZutL6N66MtB6y2cetPuVGYHJuingD38bE4k8Di3lMBA?=
 =?us-ascii?Q?llkeS6LWS3ml788puYUOPPMo+gSvDrRJ8PvnZO0MEWZAbFmA0NdRLkf5ApLh?=
 =?us-ascii?Q?oWfV1DkXZlmD1N6zhxZrSnA/VA7nDhbqLbpoTujIAzvLpnNsVUbcOdA0zZVg?=
 =?us-ascii?Q?FFbZ+cTGePMDBXbyYXjyvHFWLfge5CbXQFxx/ARaX84j/ud2Bt0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6232df8b-8bb3-4f40-039d-08dbd0cba9fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:48:55.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TQFjU6znYeVV0fQDWZ87QEa0qWe4Bs0rZ9ORB5iEfPJdNH6kc2tK4sxOx19F0NKcc5ELpQptDWGcRZ4RpXssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190151
X-Proofpoint-ORIG-GUID: 7ZIxdGim6n6RCOTVFanS2vSWQuvnL1La
X-Proofpoint-GUID: 7ZIxdGim6n6RCOTVFanS2vSWQuvnL1La
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 19, 2023 at 04:53:43PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 19, 2023 at 11:25:31AM -0400, Chuck Lever wrote:
> > The SunRPC stack manages pages (and eventually, folios) via an
> > array of struct biovec items within struct xdr_buf. We have not
> > fully committed to replacing the struct page array in xdr_buf
> > because, although the socket API supports biovec arrays, the RDMA
> > stack uses struct scatterlist rather than struct biovec.
> > 
> > This (incomplete) series explores what it might look like if the
> > RDMA core API could support struct biovec array arguments. The
> > series compiles on x86, but I haven't tested it further. I'm posting
> > early in hopes of starting further discussion.
> 
> Good call, because I think patch 2/9 is a complete non-starter.
> 
> The fundamental problem with scatterlist is that it is both input
> and output for the mapping operation.  You're replicating this mistake
> in a different data structure.

Fwiw, I'm not at all wedded to the "copy-and-paste SGL" approach.


> My vision for the future is that we have phyr as our input structure.
> That looks something like:
> 
> struct phyr {
> 	phys_addr_t start;
> 	size_t len;
> };
> 
> On 32-bit, that's 8 or 12 bytes; on 64-bit it's 16 bytes.  This is
> better than biovec because biovec is sometimes larger than that, and
> it allows specifying IO to memory that does not have a struct page.

Passing a folio rather than a page is indeed one of the benefits we
would like to gain for SunRPC.


> Our output structure can continue being called the scatterlist, but
> it needs to go on a diet and look more like:
> 
> struct scatterlist {
> 	dma_addr_t dma_address;
> 	size_t dma_length;
> };
> 
> Getting to this point is going to be a huge amount of work, and I need
> to finish folios first.  Or somebody else can work on it ;-)

I would like to see forward progress, as SunRPC has some skin in
this game. I'm happy to contribute code or review.

If there is some consensus on your proposed approach, I can start
with that.

-- 
Chuck Lever
