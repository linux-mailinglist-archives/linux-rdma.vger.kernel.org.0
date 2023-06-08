Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED57283C4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjFHPa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbjFHPa4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 11:30:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE31FE6
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 08:30:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358AMp6W011468;
        Thu, 8 Jun 2023 15:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9bVUlDvDM1IsIU7jJMB+X+XI+dnVLxnALL3eb/3s7BQ=;
 b=Yb3a1ppkX5mb7FcGFHKnfGWYsPdt5GhrglGHN1geYng7LI7qd/4hrDqTFa72mwfmY4tU
 dHODoSq1B2nQG8oxkRMfcpaSeUU1ABZjJ4bmUaGFAYl8CkDrWzveiO3hs1nB/2ShK93Z
 pOnxtn0wKXVifdb+xpCLrM8D8aQ3/DsxOODeu3nnv9dhZoOST/XmKM4YMwtYPGRwo0F0
 9/yWEBLcmP3F6p/Txqf0VjOrX34ptEG5gnWis6hKjqAtJdtbSYa2KgtOUIcKvv7LiFYt
 9It7imP9M8lftsI6+orB1xB32eJBJpdJrxfRO+Y4S1HvEt6BfE3lOVGSra8kbcS+AxQf 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uvkus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:30:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 358FU0Jn036794;
        Thu, 8 Jun 2023 15:30:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6m8txr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWbWA7A7Hjf+6Ar/xT0bRjypXLpWpiUQI+yJAMXbJYkBqL/KzbEiXhy4oCi2xEX6XrvET484ddxi9g4cWTJqZY84PtJqVxk30HkUcApkCnLt81m6Z+cSQ1rz8l8TyfVSQUoOn3/z0mmE0kt1gcqRQuYWguUiSFq039ImQfjBDxNVqIxzQKRWQ7/1M3CmZhTFQ9tclRjjV3807qjkR/AA+0nFr8aGhnGYFbRD52xYtHo3BNd38weoiJ6fCwgkKZZiaG4Xs36aYMHdkr4+6x7ySwxNzZNCcLJV7Oy/5HPvGIfpCyXI7iuuZlW2m50D0DK+CciGQq0mXZLyxUiYgcJF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bVUlDvDM1IsIU7jJMB+X+XI+dnVLxnALL3eb/3s7BQ=;
 b=XmEJtTu0rCLKz4oRcAt3c1WDSpEBk1BLX0o1zVjh9fMGrN9OwjxARlR7CfBufAXldfKRbc4P58lJBdAkXTBSiX1dxoiiQ/z2n4dGEiol05JosTpXH054higerYOwGxJ5IiNIDmsvgSDoZ1qWmqG/cVEzBL8TqcuoK8Hb9ix8RRfl8lBSJFsS7kRKxGrSzzXmrB0ubV/3dkTn05iqDtz3+BXJ8BaTYrG+n2+VbhKclTU7UOtqZKxc6ZrECIM740oIlXgh8HgN5D99Utiu8sqyOWtqJdGXqV0SUNYRh6+rY4E27x+FMsR074JSYJwEPUqVnW/NjKaypbMDmoXsPKo2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bVUlDvDM1IsIU7jJMB+X+XI+dnVLxnALL3eb/3s7BQ=;
 b=gCQOnF1XHGksva4PwnfZJJuHSRYPqAyQSdjJaIFROJbYchm114eS/K21RY4XHQpr4lGxAusARr4B/qXYBlz/f/+UI+83NB7KIrfbWXFkwXXswPt5jlqA7nzsh4V5x+hQY6BrzfGMz4iue93fTGHofki+M8DIvDymx3N7uixB4HY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 15:30:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 15:30:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bernard Metzler <BMT@zurich.ibm.com>, Tom Talpey <tom@talpey.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Topic: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Index: AQHZmXhvzGSl24EZQkuCbGf5eLkl0a+BCVmA
Date:   Thu, 8 Jun 2023 15:30:35 +0000
Message-ID: <B767CB72-28CD-4BA4-8763-F0DEEB764B53@oracle.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4292:EE_
x-ms-office365-filtering-correlation-id: f59fe65d-dfe4-4440-0f4e-08db68354e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKi5I1cGhfymG0ll1tbWd2ZEXD+1cjFdRU1IKGc/PJ5yLr9CQVZMupD+Ty2hZoVOS03i/fQF4z/Ft1QIqRjqjq4o7tDLEiQoEBs3V99IKEO9duwCnp8iCqYnJNh28otF2QirzI9RmtD77k8jbULW6/LpOZcSotWDdMT+BCzb2VNcwFOGshnJIoyMD2CT+p3XmtQ0DI+w71ZNkBe9m/KSm59dcXPaw40POtO38H2ZUrfhZdOEHsJkKlUR9JdHE/5f0CTyG7oaXzyI0H7ku/aqn9LhxOGDEWZ6OTdCOPrFkZW6AyF6JtlRyWL5+oDltvHX69HyLnRNpAY9Wtxj6tiaiHd/eObD/b29eLW7NCmm+qh2EMjv8f9CRdoKvFpNXyFUKBqrUM0tiUB5xioNlL/+0110BROZj+uPV2KZhEWBFoU+6UWOygMouXKS2/Se1WvaGHK2S3oM5SS8PEOYQdAGNxPj202qqpwW6HC1lZIFjM0CuGrvm60Lb1X8CrwXLerH1sgpuxI5tjO4qcSRmaKNbiYLaS6w2lzYn0isnjSyjIoSZ2G7mYLbGf0HMeIjeSKC3sHq0Qb21b5bUK6UjlQDJlgYSpePQPOrQJrGsqpywq6P+mdGTJTnvWj3fD1Zz2y9KDdvSTDxwMR398Wy2ddN3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(66946007)(66446008)(66556008)(64756008)(66476007)(76116006)(478600001)(54906003)(91956017)(8676002)(8936002)(36756003)(5660300002)(71200400001)(66899021)(4326008)(6916009)(316002)(41300700001)(6486002)(38100700002)(122000001)(6512007)(53546011)(38070700005)(186003)(26005)(6506007)(83380400001)(2616005)(86362001)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z/NIajUXPopgRbvAC7zfO/JnGfNRA3+quIVrQmpcZfghAuWXvH6HuAfoHOzd?=
 =?us-ascii?Q?5CmcWPxPNWvCJ6CZ2jy0V17vcPJVb4df/1ca1RrCVFam7zfw1DX5U47NJLqG?=
 =?us-ascii?Q?BlGv33oBZPwAW7rZJUUKWX0T8agsikPSTRGxbq2+RgjVIs3XsX6fTZc2Fhxg?=
 =?us-ascii?Q?328jXzsi5mam8vvCU/U5qkUhQwThCJM2/pNpUl/Q905cNBrQWW9atMUitE/H?=
 =?us-ascii?Q?GYO9TbUis875NtVf0BA5z9/GbLJv/WAPnTh+Z7Vq8qknt2u9+pxg0UBpmblp?=
 =?us-ascii?Q?4kkLTNCLA9YEUazjRApMmkLap9IgYEMTu9R3bVlMynCHUBS4CXvRez3zCe6Q?=
 =?us-ascii?Q?K8ZpYOK2amS3056+uiSf9BFHq8lRAXUESkTK6qiL8P5JfhB2a8CcZxTzg5PE?=
 =?us-ascii?Q?47NvDe5sk7ae4OTOXY2a7paO7EkKVNmhWTyP8Zumcb2OjAF9gqRptVwiMIBZ?=
 =?us-ascii?Q?flKkEA6hvqjpxJBgPZB79gl2ZH1Jp8HiPrHt6lH6VfTRxPK0UcvtFbJtf6lW?=
 =?us-ascii?Q?gZa3vg+ha0GcnVJdpyotmdRmmTXIWUi0Kot8YSukb7yTMGjotpEj6vZ4BEYt?=
 =?us-ascii?Q?RlsQu7lg0c/48KOhd/FtE0lvBfQtWsRyAPmfkw5PvQvHzWW1y6PSc2wbrqyP?=
 =?us-ascii?Q?REsqResVjq9T4XCjIkQa3ZN0QWGpGsYjis/NY86ewqASGvrXXrw8pLuSek+E?=
 =?us-ascii?Q?WQcsGUCEpeDcmAr4ls+Y42oWaok8/hBXaIQ9cRMglbYy6sbp+zuBFM9BqYki?=
 =?us-ascii?Q?x9aJHZgdj3Y7NMytCbf/wjp1bRU8g0xoeBuff0QaVRQrSec24M1dkakFkJfM?=
 =?us-ascii?Q?zRa6jp9Jv4kGD1J5YRtbdBpzCMaE7sd6efFMKbE/wkn/c4MaRTSUejvqBHct?=
 =?us-ascii?Q?HQedQcE/L2TCVIJeM35VhU6kUaS+2hZBN4ELWNXDrDv323Bm78SSTReDWgYU?=
 =?us-ascii?Q?MCa9ss12VVZIqIuSojQTtcPRIFUf7rsHb2zUOkPEXuviahGai8LqT/JAewcW?=
 =?us-ascii?Q?/Q8vs5PRBbXSgg1q/4nS5R+WX9j9zvnH6BtIWcBtgzvowlG2J7C82jRBesBP?=
 =?us-ascii?Q?l0mTTUX4M+KCFPk9/r2Hxc5J9A47tdwOjVWXBNn5e494Do/yXLguRMb/pHI4?=
 =?us-ascii?Q?febLjcjjDZ8RM4kojD9a68BExUeRjmpCVTYXqEv+EEWY/QgpstAEt7oSNJHG?=
 =?us-ascii?Q?AxDeFIhX4a5WUrinpQjZ6ob6qkAAmzE6r724CPeFNr91dbu6VWik8tXHH6sw?=
 =?us-ascii?Q?2fJmSv1cj5GGmDjvfcDn6aO3W6ozAI09RDABiD3oAAnXI05F7DpsxlXu/1FK?=
 =?us-ascii?Q?7May2YJR9q7FilRveQ6Locax95HWlpAmyPz2aqsomGYvIeDGE3pA+UOiJg91?=
 =?us-ascii?Q?MSpUdNtFJZ3Et589dXnrxi8yEjP/jZORsOIacpBayhorkg7G/mx0FU+ud1vm?=
 =?us-ascii?Q?EvR1CH2eGKyQiMPpFVM8USFcpg8hajn/y5cfu+XBMxx7x0C91AeQoPhDyBUw?=
 =?us-ascii?Q?Yf1hCNh2uQp5+COCCsibNKn/Z1WjuZ7vms3itYgKx7/jE2rHY2LWyJjYqb6o?=
 =?us-ascii?Q?0BRM3XhA4Q8BkNTZ3NAvHUp8c7WoIxL3dvemjRhr3DpEyq13DVB6OPcVCEXV?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <213CEF9F5047334FACC1756AE1DDA83F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /vA1YivijJzEKL5MjagvFDSbFfhcZlnP64majCnevhNGx0EaijRR6bNnCyLkvc+0ZLdtm8wQWPRy/DvbbEV1nK4LP4GUS4OZNacx9ob9I70/SERU5kRLlD1uoZnZ0Z33tZGwtFopNSuE8SQo4YkIhky9lgmUDvpd8A/GPE+j2W0HTK/hI3MVmuZcL4gPNbgXiwhPYUii34LLxq3xFSrHJddmjwDqyu3qu3d6TdHxip+zpowanLDHJD2FsAF2WLomrsz80BwHz4lWTQqENfjQbrb3oU+mqxk4kJ8BA3ykN20cFFTQIGUH42QtGEjjxMIWA7a1idzi3kEBc4hs+PMps6MhmybcGBwEULwnPh5qTW9IkZM30LHoc+A+q2YrPoXBVssNXpv5Vl4w2J5FTqB9b0qlEaiC0gbLuaV14PEjAT/BKcMJMCf9eqfyMzWlvPpi+pNIYNcGX/8SAN7zBoF2MUdyYNmNcnfF0x49PTw+oF4mG2pF847xJhsNBAfwKUfuBC3+wlNRjSFMZtP6AGY6b+XKEN0jA5NGgv7vF6l8Usc/6XB0UEO5uGUbzJ4Zv68JJEBMjuZ/T7Vx7sEanTjj5qHieovrx4u1r38CW7GKlU7r0Srf6PgdqhCYpIgu3pBV2iDdTIN4I0k5cE358Qm1K7KkH9B6YyDQ4YUvJKiwGmicsedLUhmGuOv1AOqtdzshac9UJUDi+g5RMUOycWU9c3wqkMFoErg8jM6MQOZkfpJVKLr3bx0NtXQLOAmUmTQ2yAQoR9UBu3zUk0f2yhyvfi8neGO67gxX+iFenST1KiW/Np8lYH7ibgfF07qKcPj8suG+s9BamSF/bRDhuFX+96m3lPC1e5HuvXmQL3LQ6q37ke/i5PVS59j8h24LHRU4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59fe65d-dfe4-4440-0f4e-08db68354e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:30:36.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pm9oMs/jsO8YgwZcGRzKvL56mLOin5KQ5+uprn5ijj34xk1qQCvqGlkwyK3vX38r39f1+AJRjKud3zNl+Pbw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_11,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080136
X-Proofpoint-GUID: XvSaacKM1_0hOXCIH4sOOYfuvTGghHss
X-Proofpoint-ORIG-GUID: XvSaacKM1_0hOXCIH4sOOYfuvTGghHss
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 7, 2023, at 3:43 PM, Chuck Lever <cel@kernel.org> wrote:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> We would like to enable the use of siw on top of a VPN that is
> constructed and managed via a tun device. That hasn't worked up
> until now because ARPHRD_NONE devices (such as tun devices) have
> no GID for the RDMA/core to look up.
>=20
> But it turns out that the egress device has already been picked for
> us. addr_handler() just has to do the right thing with it.
>=20
> Tested with siw and qedr, both initiator and target.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> drivers/infiniband/core/cma.c |    3 +++
> 1 file changed, 3 insertions(+)
>=20
> This of course needs broader testing, but it seems to work, and it's
> a little nicer than "if (dev_type =3D=3D ARPHRD_NONE)".
>=20
> One thing I discovered is that the NFS/RDMA server implementation
> does not deal at all with more than one RDMA device on the system.
> I will address that with an ib_client; SunRPC patches forthcoming.

Or maybe not.

I'm looking at cma_iw_acquire_dev(). Where is the
listen_id_priv->id.port_num field supposed to be initialized?


> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 56e568fcd32b..c9a2bdb49e3c 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
> if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
> return ERR_PTR(-ENODEV);
>=20
> + if (rdma_protocol_iwarp(device, port))
> + return rdma_get_gid_attr(device, port, 0);
> +
> if ((dev_type =3D=3D ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port=
))
> return ERR_PTR(-ENODEV);
>=20
>=20
>=20

--
Chuck Lever


