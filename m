Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44D54E664
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbiFPPun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiFPPul (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 11:50:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000B41F9E
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 08:50:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFEbD9026656;
        Thu, 16 Jun 2022 15:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GOL02UfpWvJtxS3qcih3cAsOT9DUGGc8ltwM/UGPNEY=;
 b=r2njdfnCUYZZTRrGsKOUIMVWY4ZpDU4xjYQqccm2pe/62B9Ds5URCiAoZRDCuAumLUzI
 osw77oDl3h4SvNZGky6iAYAFq99NnYMgbTNTWphPHbrGj3Db+wSHLLtE3v5bDOiGZnid
 vV5k3W84HexmqRt3vNxSTKzWJPlGMvbV5JR0RoWM2mQpX1n6UtClpkOwFFl4ZHVQUWuX
 +mytC5Ckl56kCHyQ6UR/uIefvtIaZLsR3+6lEJOSk/6AjQBXzg2m6PYhX4AYMDy00BXv
 kI9WV3+Lz4ubQEf1Y8qYPB330iVdifztJ/ZbMWa3aAty4Opw9PkZmZYF8pQb5UXzVr+B vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0kqcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:50:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GFk34X001648;
        Thu, 16 Jun 2022 15:50:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7q7eqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irgHFEjaQtAVoXkZLw+KZ5Bix0LPiw6JmXqx6erRCBErBxQg/zPuU/+Us9BDsB0FA4Uz6ZIxHmCRAX/Z1qHAZuRLC24Xe9tpOeFRGhYUAqghZU8ZnbOcyBJdoGNx8tEisT11qaHlC6tXWKi7vr6ybBEpKnY6PqoMcxV+sqXbU0Zf8xZIhbzSzwWT8w9sSaMI8iXhbyykIUgwrkMomg2m6G2YnB+0BeuXd/8pTijCd9lmUSoNtFSw8f0MoYdu18bqKvw51MwlgKyxoZJggM9WkGDTJy9XftK/AALMSe12UdVVzK2ZmnqkG8zcbfSkH6DOBphuKa+6Qv077zqP2Q+10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOL02UfpWvJtxS3qcih3cAsOT9DUGGc8ltwM/UGPNEY=;
 b=DZ+BVq7G8qE2X93da+wGV+ZCcF8Qm6Iixa2ociqIQTDPrJuO7XNLQwxRpGezkhyNmp/7oPvEXiMEYK3UMUjm3w0Cme6uACmICvYcndzz5vT+85+TYZ6HgcqgTLQUSV4/w3+mP9YsQNgwjpGLPTBJ3BkylBGkTna4vrq2f3w7TDDp8q+J1cpMbM0M8PIkwylDuC7FsrQjtCFWa3FAaeYH3Ai+3+BgFf1xgSgu2MSFPMU4NwVeYjbgAKTZueAjzF3L8NkeqT6fK9URHhcjL9Xpo8VmRSqmuL1Z0Oy2mVCJOgYMCmHMhH0XI4H4KJejtW+gyZDMoLdQDUi72qeFuIznXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOL02UfpWvJtxS3qcih3cAsOT9DUGGc8ltwM/UGPNEY=;
 b=eACWhx0WjGRWbTfH2tZg6YyHupj1OhlPkfbTHUNB2E7ywh5nPKK1MMhA9/hrZrv2fclIPK2/m12ip4aWN6HclqfNVEqblL5N32qJIsKjCgBJ4WSovv+1UfKzN7JEKWmV7r3B0FhviNswzSzVkEowZSSEsla5ugGVPnYoqYyVYTA=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by MN2PR10MB4077.namprd10.prod.outlook.com (2603:10b6:208:182::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 15:50:33 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b%7]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 15:50:33 +0000
Message-ID: <e1ec1bce637359d798a4c614e4efa94a140324d5.camel@oracle.com>
Subject: Re: [PATCH 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Thu, 16 Jun 2022 08:50:31 -0700
In-Reply-To: <YqrW0s7FII1FoBwb@unreal>
References: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
         <YqrW0s7FII1FoBwb@unreal>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:806:f3::27) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16cbb294-a4a4-4017-0a85-08da4faff29e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4077:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4077E07D2F9566D46B9A8A9E87AC9@MN2PR10MB4077.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKDLBJ/lotWbQO7PDlnHQzy8dnJysIGtqIKRB3OF3jLIN5KUn3W5V2hug6dLO7duQQnXdHRVIWiJQ0JxL/6euY2KNbbFk5pf+/7SWcZ3js6g+KFqUpnJiIZH27+Ps81NN1S/CRifo7iZd7Dp+qFyMhOrFp8AYmpPVBW2eK1vcjVZy2QUrzRdgDicQw99PJPJ3+ONmqZbsvtBhshcDQwq6tEpvOxjtD47UxOZoLIPAsqdc4IfaSwvjuttII2q6sEEUzFFUIjy1Nz9msPpw23Dfs9p/KFrnJdjJ2h3c8zkB2ZC9H4JKkDIHcfSLLnjOdCCNd1ezek+aB3wNkk5dx0Z3UVn+kgft9E6W0uiX3CDCAkxq1U1dlcOVgiAtzYMSIBvthbkFsSP2I4CSOA+mQI4VIvdlw8WjHYFO2t2UhK4/aiinlE5hLPyrlK1UqAkMDhI4FmZVgHKprnKKk6IxAY/htGJnNc2JbrHjf7InrMfFf3Pe8D83o2j/66jncvP66VjFDgILOQHIXcRmWRj32D7Z1aVCGVzDTL/KBD68S100xe0xQiraOQOALq3MyExNHJ2uOuu9fOybBqGVY6boBqGLqzAge5CAKV2gNv6SoCycKnPPHYlxn/z2nR+yXwu3sbdYBMAnkRW2PmETlrHT/OkRPbzZcPSRk75bNR6vYS29Wl43gbMh2OVOyio24cTyZto
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(52116002)(186003)(6506007)(66556008)(6512007)(2616005)(86362001)(38100700002)(83380400001)(66476007)(8676002)(8936002)(5660300002)(44832011)(36756003)(4326008)(2906002)(6916009)(316002)(6486002)(66946007)(508600001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?Rw5htEE2zBUr9kq4nxXC8ujJaiTFX2Wx7xlQPs76iFAaN3bvWgxfBIUjy?=
 =?iso-8859-15?Q?kl/5NwwECKb79+j0GurQaxHlXwPF0tSYIGGhuXyN3BKmkQvZaZ/Zzd9YE?=
 =?iso-8859-15?Q?09EnCSVFAZC3e3nRcU4jH5mIvyg/n0MxRUjBdVwJUMK7d6NZWhOWtTL3o?=
 =?iso-8859-15?Q?8UaEO0FiGFPc8pFx7btxfX7UBQXyh7Ofd4vEFnNoCPJyCsS1cbEAkXnYn?=
 =?iso-8859-15?Q?6aVxkCp7r+v38NVLe75qhfICwDelALFH51c+8jz9a3wtvgccmO/dxyNkw?=
 =?iso-8859-15?Q?/gl2xu5qGtO8zvbECsEulBIj0nR6pFdDW7XJLy3z0AGdMRdLp1zKY/wHJ?=
 =?iso-8859-15?Q?bQC9t6ujQg+zsA7y5rkSjc6hReNGpF2Nwk3Va13U441a6fWgyUhYrqxtU?=
 =?iso-8859-15?Q?7qYB3Q1shzt2BayCIwEV7L2RlGZkiefUdZfdZRZuzmnmvHtFB+UXSbwCQ?=
 =?iso-8859-15?Q?GRLMvMXIb4OLc4xDmBZS82WIwQLJ+2tJjSZkytmtB34AQvsnMExdROdIP?=
 =?iso-8859-15?Q?Bdm2cKuhdTb+HaUjjcvMluSJ6U+WIrAenFO7rUkbEnuVu/ZAUol3l0nQq?=
 =?iso-8859-15?Q?XfpHLarPEDKyLUot7clMhtqWPk0Jgsp/T5x7BQEyRoGA5zpj5Dy03fr4B?=
 =?iso-8859-15?Q?y0S+Yws+r+gPtlk1T2cYWP5TX0sjHr7fsJaS0Nd7h6v01eS5Cx4fsZJCr?=
 =?iso-8859-15?Q?GaslHSw+UwOKtUl8NYa2Bv4aD/hJHcD7hA1Tjkl2RE4MvPwpbuvPWZX9H?=
 =?iso-8859-15?Q?/Rz+dIUbjIWeplWuCt2OVCpsavyTG2Fu9mDZV8SR2i59Emx5AZxKaj0ev?=
 =?iso-8859-15?Q?oNQkkF734JqoC6DtvT/TKsQYlDZNFKszKhI0VW1K02Hw+kvLBMS/mOyFu?=
 =?iso-8859-15?Q?K1v93sRkD7tfperNmB85RNKkZn+KE456vpW9J0sjWeW3Yuxhn8Af7BHiP?=
 =?iso-8859-15?Q?DodPIwUGTuvJ0GWnzbkAXsI9jonehDX64QO8qoDzAGUDw1pBIWgM0TBnz?=
 =?iso-8859-15?Q?r1jXHiUne6Y+BOCQCsZRhoWTf8WT78eom1qjrgvWPwEA3nUFVGPBqWPaR?=
 =?iso-8859-15?Q?ro64uC3wDvTJeTI6zag5xLkwixlw0Ns502HRrlJaaRGUK/dC1RjyCYh9D?=
 =?iso-8859-15?Q?8vTm/fqnceaHPj1NCxDjIxRHdwxTco5kpeHBmOIm3EBJuhC6jnw3neY9z?=
 =?iso-8859-15?Q?Hm6ntAw4pzYsb2CH78X7Z/Ca3qUZ1OAVQ2MnhFrwMGXfzJr+6s+RQiAX7?=
 =?iso-8859-15?Q?VDmqaz1aNUiGxTE7PW+8IJ1w705hqy3SFW/bmm5WC83T5CjS2KmzYHTbZ?=
 =?iso-8859-15?Q?vTqGe5CSQcyM/WmphSenu4OuUxmWaYDvNZNvdWAfKSbDifH8yEqDIFuhi?=
 =?iso-8859-15?Q?ICG4uaoNPjpcf3Mw7gx1rpclIvcnXv8V/1x4wx8/d8JWTzc/F0QH9tYJ4?=
 =?iso-8859-15?Q?T77x8P0Q9mQsi+AcVa8WSxp2T3Tp7uH5aP9fp+qHQDohPabRvzD9vbr3y?=
 =?iso-8859-15?Q?B+A5dNNTasuADxRGRY76FBbT4DIiwzp7JL+J4E75kcNLIly1qi0GrubkX?=
 =?iso-8859-15?Q?b15akqB5qXSEHMgPCVwZ4oIUMq94QIXR6w8Owd0/wHYITkhiMAx/u2Qzp?=
 =?iso-8859-15?Q?rI4xWZ61qs6vmFVM5s/+WlHQSL/ud20zxt0vVUyzukfJQU9gRN9uzL/oS?=
 =?iso-8859-15?Q?T8aUkTDoiCQfH1SasH12opTDRCzmXO3vkkTCHtHpTiI84O7OWZ55awVX2?=
 =?iso-8859-15?Q?kFnDCmpASIhwR/bQz5zkS5bzLEEDuoYVaumAOgRS8R2JFrnmUea6qHpto?=
 =?iso-8859-15?Q?PxzpL4hNAZ1JIAB8d9b+5xJ5JfZl4IQaTJwNlFxF1DPbjsKqUGh3AWhd+?=
 =?iso-8859-15?Q?dK8gpllHNpJloRn4M+88EsNI3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cbb294-a4a4-4017-0a85-08da4faff29e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:50:33.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKO+ASmQuan4Lk9Kn+UWZ4krjyueNtWAYKg/T1Rxj6pErIrmP3PIO97WK6X0AU+wVE8Tp/+DxmlwoFIzFgbuPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4077
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_11:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160065
X-Proofpoint-GUID: nNNXxLHycNLQzkJRfLFtbe05RoVFAf63
X-Proofpoint-ORIG-GUID: nNNXxLHycNLQzkJRfLFtbe05RoVFAf63
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2022-06-16 at 10:08 +0300, Leon Romanovsky wrote:
> On Mon, Jun 06, 2022 at 12:38:36PM -0700, Gerd Rausch wrote:
> > Unlike with IPv[46], where "ip_finish_output2" triggers
> > a refresh of STALE neighbour entries via "neigh_output",
> > "rdma_resolve_addr" never triggers an update.
> > 
> > If a wrong STALE entry ever enters the cache, it'll remain
> > wrong forever (unless refreshed via TCP/IP, or otherwise).
> > 
> > Let the cache inconsistency resolve itself by triggering
> > an update from "rdma_resolve_addr".
> > 
> > Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> > ---
> >  drivers/infiniband/core/addr.c | 40 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> 
> Gerd,
> 
> Do you plan to resubmit the patch?
> There is a complain from kbuild robot.
> 
> 

Hi Leon,

The kbuild robot complained about a __be32 passed as u32.
I'll simply add a "(__force u32)" cast as is done in other places.

I didn't want to make a lot of noise by re-submitting for such a simple
change, but I can certainly re-submit, and will do so.

Thanks,

  Gerd


