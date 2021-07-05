Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA23BC12B
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhGEPsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 11:48:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61692 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhGEPsh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 11:48:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165FjsO6008845;
        Mon, 5 Jul 2021 15:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=0m2WP/Sp6TnxG8yDwuWR7tHrW0FUqnBy2RGRppfvYm4=;
 b=lzxsniRB4pR+CSoO0T1rso3dWkhGQMeNK6+pRDs1Vf1JvtacMKrDP688+6UQwosaReea
 aCCMeoGqsnNVz9qu8yi8u9d46cQTisi59IafhU2afK5UEQ/9rqsc/Cq6KuZwKKtaAfN5
 +OTb1qiFLEgpIo36mgeeh7G5yXi250iGSNRof7/a3uoDEQpxBXiiXcRj3MHSpBPAskw4
 ohch60uThw8tX39pk5u+QqG6duqmp5p3HVJgaebBAPd1hdD1d9pp4TPY5RNxNSV6vxiC
 ZtMZW/GPbx3O8ZJcjwC0LytgtFYwlkrcW2TFHraoRDU5QK5ZR9sgSxRLufpw2l3chr7z mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mh84v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 15:45:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165FaETQ109451;
        Mon, 5 Jul 2021 15:45:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 39jfq72ru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 15:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlBNEES8RxoSL0MIZbK3zqvNMufJz+gSgINJQzVebbD2DYIBZVy07bkhHIin0jEFW21o1yuNBBt0UKsLGOfLxEwprxiSqV2cFWUOof2iDLPOzvTQGn5Hc10CaX4cI8A2mJsXBCHs4A5aLEu0IAmzM8CCagNe6VnMBl93xGp8tkVuBNnYEvQ6KCJE7BJ4RKVIW1VaCnCsY8zdhfDLh7DmJmHFvXF+0ZHP9gUaTVIrmVUGGugoo9gMKjYiD9gf3gXulKrcLrxLam/9slfScm86Bi7qOhSHtKv3hN868aoAeXrexr1qgp8tHp1yTnGpTMaPc94Z4ipGvImY+76669lLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m2WP/Sp6TnxG8yDwuWR7tHrW0FUqnBy2RGRppfvYm4=;
 b=F2WO3S36mS3e1qg2XvQy5i736Mb3StWPsGkY48jjCyuiyFRP5ajiYdrrY+Y1uDOy5ccQL5vOpfxTLtmhSWnVvtQZ3LVBPqWHszWZh6bMF2YrJN8++fVIS7gXtC7uf0N6FBxzbnMyhz9ZeoX03YQGYHcewG8upM9q82J6Q4x0wry1blHRCgzNTlhTUvfHow5gsgYFF1IsxtD5leEU9NqI4+pmGDpVdpd40XzUlCgaXP/5IdvRPjoBEJDng9IU3dGA2mkWTRERI2CEG9sHdjLXmFFb9o3gqKbyDUYEDdHfGPyVxkpwIWaa7qwP7Ka1IWo1JnZGFtyYZPcj1nrtR17MLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m2WP/Sp6TnxG8yDwuWR7tHrW0FUqnBy2RGRppfvYm4=;
 b=om/moTEv3CITUe4yFFMdtGj2GOQQmQ+Sl7ch6UdUvD8JmkqDOwod3F4QgV+AJ9hmyLcTZ1iCpi4KAYld5Vh1mw14nfPIX/eKNieDISBC34lmn0Lnw0fn4y7tBIi7Bek+zgXH3ejpMqxRbg2dpVrTmn8mPExx8iiHh1g2EmhPps0=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2397.namprd10.prod.outlook.com
 (2603:10b6:301:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 5 Jul
 2021 15:45:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:45:44 +0000
Date:   Mon, 5 Jul 2021 18:45:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>, umalhi@cisco.com,
        linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
Message-ID: <20210705154526.GI26672@kadam>
References: <YOLdvTe4MJ4kS01z@mwanda>
 <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
 <20210705152138.GH4604@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705152138.GH4604@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 15:45:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64b5900-acd2-474f-c8a2-08d93fcbf36c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2397A29139493080180D61C68E1C9@MWHPR1001MB2397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STg1VFTVqPXvLvmZ/V5Xjy0EVPu9zkHoxT6aGy1LI7x3+eZYWmJoEP2hHgXTyU8UMuZdkN7XzKBjdQlvvoorXwXS7vA6ABHqyMLYALAPbYUVrfxoZnVTqUnvLFB3Ug9+3CWS7go9zsO2Z2qNzML95z/QNbuB2gqpIdb1nrrDJw+19R39wuewBRfYidpLvf0zMY3nN2Ggj3+Jy2MK0u1CeKsstVeyH6IsHH7I335qmUQlxCopcu8M+9YYVac1kyaHcfRH5qvHa9JhSYImYIqDNi2PvVVH+V5KsR1V6UGbjG19/7pfRqAvrAI01y/SWVM1I3PTKmp0oaVkYGh1KyjmYgXAJnOXXLfM5TbWM3tPlolxjNLVu3YZnP53qVc4XSIJjOrPmcIkC+V2BzfT2oNd89qdmeHfV1YryRFLDfOKOhj/jMLgeCML1jcBXJk0TgG4X/tWXhXjY9g+XUWjaTBfG0rZUmL4nPvpj1EJ73btwvSaU4j6Y8IKxdqtHt/bcoQLERDDufYXcElZMlC+ZmyvG5zKHr13LKOI7xiBgwml5tVItlHXBpqA+CY+vJykjRO0IjFV5HgIhnzteq2JOlvSerx3h8CEa/TNxay1l6GbM2h2IJC/lDkdSGCAsQd//7AbsDiSHir6LGUU0380aRHf359zNK5fRRHODaepSelC+3z4ck42+wlIOIugEdkScf3ILPvUHoJ0BR0fyE9S0nF0Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(16526019)(8676002)(6916009)(8936002)(53546011)(44832011)(26005)(33716001)(956004)(38100700002)(186003)(33656002)(2906002)(86362001)(52116002)(6666004)(54906003)(316002)(9686003)(6496006)(66556008)(9576002)(66946007)(83380400001)(4326008)(1076003)(5660300002)(478600001)(55016002)(38350700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Htn84lkOiKVNNoJlt8SJRswMuacK7SINaT9bs7PNqeac53MWvjxQPdCwaYQ?=
 =?us-ascii?Q?DizzzIF2xBoFYlWsoGJDxtvrRoBrB51hcEbj0MGyX7VvU/SjRCEUZZ4hrJCJ?=
 =?us-ascii?Q?96Ivj+ezRlTwTaYXqauWOaFW8sfRJ+PiyDbWgwkGO2kfCIXgYUUJ2Vh2zZZ3?=
 =?us-ascii?Q?bMRasnO0K+8PRJq3WaVs4s3klu8uByLXaJB3tLyqaB65J1rar4xtChgjwgVV?=
 =?us-ascii?Q?/sGx8KyrQ0P1RUzTs4lJ72Xe6Gng+Q+GsyV+EYoV6x0fb2C5vyfRnx/fir+D?=
 =?us-ascii?Q?YkHCQyH3HZrivG6o19O/txq8HPBNxSG9kfm1mCpfnztN81pns8JGwlsE6fk9?=
 =?us-ascii?Q?ggpQp0cuDpPow36AnLF80bYSFie1YXrNHDmr+GCiM2oRZ8MwAnkLLEJsf9JH?=
 =?us-ascii?Q?9UyPpHjPtdZIq9AFNc1tL4S5g/kRwtCwPphgiLPmMRQoFP+i6Y1i1RTvw6nx?=
 =?us-ascii?Q?WnWibYqk7n4RI+ON/b786lRMNvZqyfthjkGEAADKaYGZDDSg/jjZ9N/A+1HE?=
 =?us-ascii?Q?r7aGOeSSsXm7PE+OXfmZcvMNJQUhAzHA32FMGplhji67iZPZMT95xOo4XU0Y?=
 =?us-ascii?Q?NSBvxNO+NKe2iI45T1PtynGTAyxz/KYf4z8w6ECL5L3C+m4Z/LW0tUdRAzib?=
 =?us-ascii?Q?3eQI24DMwN9uGyO2Hxe3FD/mipPoYYEdRX3t2cnJc0O766NvOqQuwm6P5sRM?=
 =?us-ascii?Q?fH374z9kkOZELRN5UypscV2sMrVHyS8N4kg9SjzfzkynKBwpzUQ/i5RRxfkE?=
 =?us-ascii?Q?7ouT9CogYaKhDQyHaWwozf4/5zKp8H16f/L4MrjbZl8O6z3Vn6EshkJyyVQr?=
 =?us-ascii?Q?2GS6iL1ZyTPhrhUFg4l0Y4HCkSY6OFzFp7B7Gsf0wJU6wtn0/mp5ic8VC8/x?=
 =?us-ascii?Q?xfNs9ltWHfKemj7Y+7FZ8X+etxO8UnnzCQSWNgS+iz9frV+fjJt4og/kqDe4?=
 =?us-ascii?Q?x+Nb0Ri9KbNIqDfRbGhgaVrIS13N0WUDYO/mrCJwGT0aKJu0gegWnaLFADo+?=
 =?us-ascii?Q?w1o09X+7SNnRlxoBopY3Qbexryvqw495cwC2u4QEfO+Ly00j0H/QMcRc/IIR?=
 =?us-ascii?Q?46DegLGk1Ck/PEU2EtT/mvNsocd3T5yjUdYAnGAWtmdbReRUzIdw158wNpVr?=
 =?us-ascii?Q?uda0TDIoorIrMwFcfsgM8ocMuZ0oC32KUmpumQtjNwnlwEC++oZDVhSsQvId?=
 =?us-ascii?Q?r0Cdl76Qnxdtg5tyCMTgcZkXa+s/3kRAYgJLhwYAExvGX926hRIERj3ujJQH?=
 =?us-ascii?Q?CfU4TS5V5Q5BvPyt0C5/g2tcBOKJXZlR4S+iSVgOWomTnbCRVPA3MuPrLfrY?=
 =?us-ascii?Q?UC+A31G6Sg7PIN/6sDRZ6xJP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64b5900-acd2-474f-c8a2-08d93fcbf36c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:45:44.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuqncu3EmJLB0DO9kdjLbPR7zgc/50Ht4E9qdM4kUftfKjQy0Prww2pzjaVA+ZA5gq4G57St2mZBWbmXMNtHdOq9l/BBl/SErTpJqpgVOig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050082
X-Proofpoint-GUID: q0k01_aihWGPx7iXWSzgvPblZkyXVtM4
X-Proofpoint-ORIG-GUID: q0k01_aihWGPx7iXWSzgvPblZkyXVtM4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 05, 2021 at 12:21:38PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 05, 2021 at 02:47:36PM +0100, Robin Murphy wrote:
> > On 2021-07-05 11:23, Dan Carpenter wrote:
> > > [ Ancient code, but the bug seems real enough still.  -dan ]
> > > 
> > > Hello Upinder Malhi,
> > > 
> > > The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
> > > driver" from Sep 10, 2013, leads to the following static checker
> > > warning:
> > > 
> > > 	drivers/iommu/iommu.c:2482 iommu_map()
> > > 	warn: sleeping in atomic context
> > > 
> > > drivers/infiniband/hw/usnic/usnic_uiom.c
> > >     244  static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
> > >     245                                                  struct usnic_uiom_reg *uiomr)
> > > 
> > > This function is always called from usnic_uiom_reg_get() which is holding
> > > spin_lock(&pd->lock); so it can't sleep.
> > 
> > FWIW back in those days it wasn't really well defined whether iommu_map()
> > was callable from non-sleeping contexts (the arch/arm DMA API code relied on
> > it, for instance). It was only formalised 2 years ago by 781ca2de89ba
> > ("iommu: Add gfp parameter to iommu_ops::map") which introduced the
> > might_sleep() check that's firing there. I guess these calls want to be
> > updated to iommu_map_atomic() now.
> 
> Does this mean this driver doesn't work at all upstream? I would be
> quite interested to delete it.

It just means it hasn't been used with CONFIG_DEBUG_ATOMIC_SLEEP enabled
within the past two years.

regards,
dan carpenter

