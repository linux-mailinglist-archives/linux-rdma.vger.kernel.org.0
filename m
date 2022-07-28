Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95058456B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiG1Rzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiG1Rzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:55:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946719001
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:55:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGxpsp021898;
        Thu, 28 Jul 2022 17:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JjZ4pjTM620K2B3TTVBo6GbjdQscmGX0p9t2lVFevCk=;
 b=BX5h1zQva5bddThWBTshYwvmkQjaOGrwhtiDrkKfaRMpsH1fb7DOE1iKHD2YY2yrBvAq
 gjlCjdTh160eMOXOZWdVoAqpgoCVTGAxcXidyc4o6EmXJqTk72Si4L6t5A2+UmFS5O7T
 xvU7wDybsnyBuvt239S6DbtkAPONudz14xgTmM0I1AoPRplQAUjJpKYKmL/hWGBuE/O/
 4NVBZwmbobVkfrAYXT/T7sPM3FBc+1jONsHqwdYq4jzvZHx7edP133nEMc4WA3ZW7Aih
 THphpnJ7pBNf4yRw7h6UUT/VT/lE3+BjFCt3oMapmG2xhTDkNBwNi9/9Ar27r8OXSbvG gA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hswuxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:55:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SHteiC023248;
        Thu, 28 Jul 2022 17:55:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yxtbyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTE+8kid8X2fiQgnOislrHEJ7N/a9pWZV+jbU0oCrU/iqPuqbnotZ7ciw6ZmlmPR2fcNEVtSQMZW5jBsxWZDM0GfDVh3n6MIr/OyXcTVq9kxPoojMSFvfVQodtkehx8zMlZDQJu7zufoonkdJV1XXPjLJaADxLLgt0OOW1LuyvVUAY28t8Z1kpG/w6WVh24k7rwoB+HjpfBkP7GVQjsiaFYK8IVOkQCHPgaQ33THILTkwccuqpWHTds1SU6Fvd3ZvPLS96wImjItVShYiNrB4FIfbA/tJz7DtGZbJl4zrZ/lchEWSp8ZZ6njeJBVxiFAF3OIwq/VVZGL/HcF/jI4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjZ4pjTM620K2B3TTVBo6GbjdQscmGX0p9t2lVFevCk=;
 b=aH82B9xfCYW9yiWzQAJWY/bJPeQXLxLBvn9JlWWQTGv+SbDmIGt6HYr0NUJI1+FwcMOaxV2ijR5Ft9M9ycqw2ZJx/Z2SClBzojmGiPyoFhz1ReFoXSz+sZ7mvSn4iDMYKtSNxMrxB0AS5cjhSh66+z7Q6mtAuNSdT0TdadcrKKvGyOpva5IqF4QV1luBSkUolI1S3EkcMm8PSsPZCNx9cLyX3nsnrJhIT/BMfR6LQnpMBFXmkSGhxi+mlMF6tdEMlx0E0SXeuvV1Mw8QZj1Xvia/dZNSwhuf9AVCGUxLePCT8h5cfA7dRSVd6q9vmSBaE0XjG4tmd/8HF5cYgXDtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjZ4pjTM620K2B3TTVBo6GbjdQscmGX0p9t2lVFevCk=;
 b=U8lVkwJoyze8tMkcXYdEuw9olYzNZE3Z3u8LH2snWldXZ+pcdetKuj0SZfbKxQugKDG6nGDqY5GmUM8zfesHkrH2wB6Sof9eq3C2XdigSDWMIlX2fNhXbiVKoWlZjgHKzxfkKHA7s7MtSzJNUOFnJFC09BUFERVYiKdrYkZdR58=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 28 Jul
 2022 17:55:41 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::11ab:5326:2d9c:936c]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::11ab:5326:2d9c:936c%7]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:55:41 +0000
Message-ID: <94874f65fe9696ccd671625bdc6bfdc4cc496e30.camel@oracle.com>
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Thu, 28 Jul 2022 10:55:39 -0700
In-Reply-To: <3a50586afd22c1872dfe3f8fbc22438f7cb82cca.camel@oracle.com>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
         <20220624231134.GE23621@ziepe.ca>
         <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
         <20220625001040.GH23621@ziepe.ca>
         <3a50586afd22c1872dfe3f8fbc22438f7cb82cca.camel@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:806:127::27) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 438f6b8a-6fb8-44b3-7ec4-08da70c2632a
X-MS-TrafficTypeDiagnostic: PH0PR10MB5660:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py+TSKNqBOj+pANsuAieG/qn29OarqLRdCi2vCoTELvxHmAib1lxzyHQpjnzTQpjXxa3frrMDO/fYAz+2PMqjAEAPFv12oDPL0VjnUS7PIX380GGjGDSeQmHoOt0byzJDpQCDZpqaTB1N+C7T8NBTXI9hqFlG2uGvqrUHWH1CzXIs1Y/yFASf7yu8ZDku5nG/fimHkdcOXPU9/vN9/vS67dTflnI9jGANE2dyX32ic3cRjUn95Q9GTCAzCePieGg9ACn+zBkP802QSvw2USnW9WoKzfmVquRS58d20YYbDQOIbuyoQFkSdUcSiXhrYqS0zUwV2gxILjJoy58aTQTA3GMzbb4WVBvgUz6wiCmBkRDj4mWnZ4iJeUH+OVnATezS6xoxTZcHkp2ldQWXCj4Ngh4VtYUMm0La8d/UUVLhEa/owDZtGhdol65hR1jjzhSx/mxphi6mJvJL+nc3OwyltRgo9amjDvZaJY6m1a2yyW9fBJwI+bkWYvhJKtSUae92qoODvD9tp6f1uytk7X5IZpREZlkhLmLfVLtEtTiqYgVIM9cC0IxKeKTjih02CgDaZu6kmqK4ZIzb2hCzjfMjEpOFNInEK4HXbllfqk7S/78rThQNRc7zkgpuLrLjNhEPIry4ab/qEyw7UDSrJ889RqM74e8fEYqs+wQGBzoWDEow4DHeOf/5kzRkbC72z1tculdXqQTGwZd0x2/3O+s+GR9G+fisb20ZsLB5EN4+TmhY32iB7Y200m+aRc7GA32Q7mWpHK1M+KgNzgnymG/ETr8c+rNgZb/xEqJKta9am4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(8936002)(44832011)(5660300002)(6486002)(38100700002)(2906002)(478600001)(36756003)(316002)(4326008)(83380400001)(6916009)(86362001)(66946007)(41300700001)(52116002)(66556008)(66476007)(186003)(6506007)(2616005)(8676002)(6512007)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?KsJrqvVEFAkpH7egJUqFShmzbbdfaK2+s9oonLyxDngDnborFntUN+Zav?=
 =?iso-8859-15?Q?yo5pSRvCLFtiXxItXfvRBpjkCEyymDhitm/uWdfoqBoKja0kbmeO7VpBR?=
 =?iso-8859-15?Q?JucVLlAOv+P8dD1xuIOSpNIp2rRzHt/ZDUD67L3HQyejtv28SOSqAI0ol?=
 =?iso-8859-15?Q?BMUdGGWU3X7MHfTyIsnH4OQne5pFej9Ak3LroK+Py9aTJUAmRyL5IKXfZ?=
 =?iso-8859-15?Q?XvPDZkQru+N5pZn2JPgTkiRIbHT4+xWiA6O9kilRmHSoR59C0NaN/L2Xu?=
 =?iso-8859-15?Q?oWcJLv42DbkUcxB2lN0cQQxDJxJO/1kIGBKBUg1bcbiiVWu2p8RrbOiU0?=
 =?iso-8859-15?Q?GecUNTWlVl2g5Y3lNNH5OTYVrL/0TbTjCdeoxWcSDIB3sH5xN+oYi2gs2?=
 =?iso-8859-15?Q?xzEgHwKEa3f6eIs85+t/bmdk9H6DGRkwF2rSdMsnjdy0NrnHpXhAg4oLf?=
 =?iso-8859-15?Q?MewNT9zH/hJZcSLMMWAem1k/N1mZfO/lZVn9h962m+pNxr4ebcAnbJGLu?=
 =?iso-8859-15?Q?Ew5W2puitCrLucK4vGqyiLS904twA39Il5tubnYwGzi1x/e1rY7fFAVfd?=
 =?iso-8859-15?Q?eqCmzqy/+FkBAdqU2JpdN/U2QNCemF4Z6D4bVbB3/N/vQ5UDWB5KFl/lg?=
 =?iso-8859-15?Q?/ko0KQui1Q3ldIybQLy69O2Hlx8Hdze+bfYw4KnWlQPUHYyE18RcdySgX?=
 =?iso-8859-15?Q?6Rm8g2f7SHM1jeFI21CpYHJIFrSZJThpVem21Y4rlheP7J5Ks4p3iigSR?=
 =?iso-8859-15?Q?5AKBCvLf/YvrkWXF4JOI8zS5vLLttz7/CDgupuAY3iYT+C0PJzUT2DbpN?=
 =?iso-8859-15?Q?CX21uhXjvMkBMMiYDiJSLmds6i1ZBSpgDbfLyvD53i6L8z0Dqt+0zBayh?=
 =?iso-8859-15?Q?k5tHR7uRnxVkVNNx0DceixYB64rz/TGOrQqly3zrq+ey4JWOA5GTZUOnQ?=
 =?iso-8859-15?Q?9bPUUx7uLtfT0C1qqXMtCM1o5wHEzWbM3yk+haD5rZ7SbR+v5Pa8LklMx?=
 =?iso-8859-15?Q?GKpM+efqfmxKARBYba3wG2O5Y9FRXmJzveBIjewk39Vd6IwpzpO/8Lnt8?=
 =?iso-8859-15?Q?89QfSMSYqpnOvsJJszU+oIFO/AhnjGQhALRb+qisnvpHJ/PNYmG80mrEX?=
 =?iso-8859-15?Q?n6t7hDBkYnc7ww1pupvXtfXtcOUE8/OF3Hz717urtU8PlJLnIr59xYgv3?=
 =?iso-8859-15?Q?m1lP0ALcG5aeeA2Dtxg/n5QSrGcTanIL8B6qqTXkF/g/uZjrZfUWl77Vv?=
 =?iso-8859-15?Q?qsIIoqac+ZYiPQVT0MBWpxfSUZirEOkAAtXFqQ/+E4DRI5Kj0FI0XDV3c?=
 =?iso-8859-15?Q?IGBTl1fypPB+542pQyMKWMU65v5WP9Vf/p6qN9IY8KvTDIa2SiMCUDjkZ?=
 =?iso-8859-15?Q?TKu1Cs+DHD/kFTdP8beU1j3+12EIMS0Bobmy6f2X8HuLP8uEp4I8J9E8v?=
 =?iso-8859-15?Q?JdiAvYukPCgb6QN61xglcTbR98cy2iOBCUTTaDWxhXWpUyNCD8jlvyO98?=
 =?iso-8859-15?Q?ZFbnMHktPZ751C2NnD/GmkuxIDPwBdr0gEaeqQKeusg7w9tmpSaD80awT?=
 =?iso-8859-15?Q?gHDE/Xar1+dc617EMqul+Mqqs9zXFmUU0H+2v9GuqKmHC56TGw3pFfHan?=
 =?iso-8859-15?Q?mdDH8IqKPT+tX0tY+HE/j34u3Y4ku72U3Has+Mjkll2RyCtcdqYLWV29x?=
 =?iso-8859-15?Q?i6Xm6rnTIldmLuOc9xEPR3NvZoS94qdP/g3yG+BkMHHeXzc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438f6b8a-6fb8-44b3-7ec4-08da70c2632a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:55:41.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3GgjC/5ps2apzvK28Fx9nDjG942G8DljYLo2r1hnbdWw+jldjiBbrOkG26Ahjp8tB95Nf/0Atwj7gbr1CdXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=907
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280083
X-Proofpoint-ORIG-GUID: uT2pEb8XYf8cDQtAnIkewJBVBmHBRmAi
X-Proofpoint-GUID: uT2pEb8XYf8cDQtAnIkewJBVBmHBRmAi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Fri, 2022-06-24 at 17:55 -0700, Gerd Rausch wrote:
> In other words, I don't see how the STALE case was covered, and I'd have
> to guess wether the -ENODATA coupling was intentional or accidental.
> 
> Now it may be perfectly possible to just make the "neigh_event_send"
> call above unconditional and call it a day.
> 
> I mean, simpler fixes always win over more complex ones.
> 
> But, I personally don't know the twists & turns of this code well enough
> to be able to assert that this won't leave any non-covered conditional
> corner cases. I certainly hadn't tested that.
> 

I finally got around to trying the much simpler fix, and it appears to
work just as well:

--------%<--------%<--------%<--------%<--------%<--------%<--------
--- drivers/infiniband/core/addr.c-
+++ drivers/infiniband/core/addr.c
@@ -336,11 +336,11 @@ static int dst_fetch_ha(const struct dst
 		return -ENODATA;
 
 	if (!(n->nud_state & NUD_VALID)) {
-		neigh_event_send(n, NULL);
 		ret = -ENODATA;
 	} else {
 		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);
 	}
+	neigh_event_send(n, NULL);
 
 	neigh_release(n);
 
--------%<--------%<--------%<--------%<--------%<--------%<--------

Tested with IPv4 only, but this should work just as well with IPv6:

STALE neighbor entries transition to DELAY -> REACHABLE with this
change, i.e. the entries get updated.

Thanks,

  Gerd


