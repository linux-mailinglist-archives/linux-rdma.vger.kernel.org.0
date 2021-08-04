Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD13DFDA7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhHDJIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 05:08:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12184 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236928AbhHDJIw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 05:08:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17495T2J031302;
        Wed, 4 Aug 2021 09:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HWpD9yI/J3QwrcTjOklU+hWY1Abtvo7J1jpmXzJv8Ic=;
 b=gkn6YB7LVrCKZDwqrn961bkMVdXwQiOdXHYE1HNanl62OXB5uxFHwxGaQvomgjCjI3n1
 cxDkR/ZUGe7u9J69om2rNeUTnS+mNXUceJIm631YGqFKaPs2Igb9vO1L1YOdF5EVe9fN
 LS4zfE5jb9geq1W+bzPIL6NPIWBCoU/Arc63VsouT3k9oN+EDUzYmDdyoUMIRj1jAG/N
 JINYyK57dadj561q22D1tFEjJliOzn6xJ4+fZ+c7+ZjIcG+LpcJT7t+kt0XraHvsEyth
 tp7CZirm9W6wCNRai0yAa3E/d7OenksZWLAYNw2eapQEvJ2fmKRt970AUTOXKJwquP3y VA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=HWpD9yI/J3QwrcTjOklU+hWY1Abtvo7J1jpmXzJv8Ic=;
 b=uL4r7DS0U24VjS7sLEgSMeNxW2/4KZGHYbLSiRhBzwO0rpfmgo2y2lOHc2DMv1xbnGHd
 gyfLi2sg8voY4MKyqKBloK7sZoGdF+HHj+KeOV61C63Bb6tK6uF8Nbcqo5XAgey4HK7U
 ZPYCRUGLw5xfx75L4LyJ+1+eSaFfdqO8lP7ZpyLFCBCkaELn5PmxdZArBjsM+64HW927
 Rt2ozNINNjfQuQ+m/aedADiTp+whJKqZrP358ySUui3uEHFIUJZSdeX9d01kHMNLN4hq
 lnlX9Lv7owahrRCAZ4VG1t9Ty1q5AjjLzV3UJ6QRdvne86kuorexTIkskSfZ91kTbUbK wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq09f1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 09:08:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17495S0J196284;
        Wed, 4 Aug 2021 09:08:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3a4un1avpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 09:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzvcJgVV8VB09TqeStA7w8XstrsWfZW09OCgz/dLz9P4LUz/plpF6Wh59u/gNoWXAEEIkf/ZEYd/IaCf7r8IpmZba02AKwL2Tn4YCOVYcnDgX3UxQ9CW2CH22b4M40oyeulo32ePzjsKb1nFNSW1V01ack/66zqw6FTwqfQ4D5O6x7zSo87DwJ5CdMfYlHjYVGkW7Wi7uJbjI/E0UoC6GkoW1jGc/Dj0un6Q4OyyWP+8wonJUTk5lxG+CFVHokJnN3rWmB0pACtuWgVSOEM5AOfNmpQ97mxugt8/ANdgGEkI/GPWaawV0ex1nq80qg2EmnydILQbwuBBzVXOz2BMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWpD9yI/J3QwrcTjOklU+hWY1Abtvo7J1jpmXzJv8Ic=;
 b=Nja4utOoZYBX8jOzmGff0p2oeFzZK9ap70YWY+8FXPcSLkWBCf9ab2NwFql936FLPOfZygW3PA3gn3OGUi6cQHfONV6t/QQ54wACzmjUk+m0/I4FekT2FrDHnU4ABnhtn4okld2Ya3V3bYltzKssDtVGRJgjQ8wqsfwQPmZ+KoEsq1CcLPQG4g10lwZFPT5tHnmExxfBAXLMe6XwnUeErM4K//3OYiMzWrdkXO6F/AcAroDWEpRylqojT+W5SNv5FUShz9UmVC4zw8dSzZE6Gd+AKdOAABplueCjWI+fAoQerPyINnDDVA6okxF7V1EkmdjlxdOvb3ccqxP+eM9QWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWpD9yI/J3QwrcTjOklU+hWY1Abtvo7J1jpmXzJv8Ic=;
 b=PClubMT2Eepc70M5IE0y3gjORks6FndZpSnl1QGhsxrm2JO8UxE3zMvYksOvuTvHsNWe6P8kMcElPnOu9w5oCHwXS45Gb3NziqHoJUOywM4uuIjRvu3Wrhh1XyRaTXJqZxGBqh+VrvJrzGb+ZAYKEOBp2/K2b4Qa9UhaXr2a/EA=
Authentication-Results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4578.namprd10.prod.outlook.com
 (2603:10b6:303:9e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 09:08:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:08:22 +0000
Date:   Wed, 4 Aug 2021 12:08:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     umalhi@cisco.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
Message-ID: <20210804090810.GA6406@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 09:08:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc11a13-8bf4-463e-906b-08d957276872
X-MS-TrafficTypeDiagnostic: CO1PR10MB4578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45784E378B6D6E0E496BA4668EF19@CO1PR10MB4578.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OJYU8+QuHgCinMOIerxR9O5PVm2YowI32FanV62ETySnEahoYUn2NWOTwUbBOTqeDQl+nFcEE5pZ0meyJj6Grnmdm5Vj1HoZZ8upU6xgElVV/uNoWe2c8OD3sQapZ409iRlntqNojIEEqpdzgTzEQRKHNdCqU4aM/ZzQxZrsNENi4x+kfwq9sChPEY1DTGQmy5+U2jnGVG6tS60kJG6Z05PeN4Q2MI07bcaufcVRnAzi2kDS/AJ2Y+N9Se6yMo1GvhVhcT2ncnH0Sn3BvmsKt0NTPYB8NuzcbQKNxfO6GkH0IYEInzIuYNJypT9X1vottgn690sAPH2836TSCH6XPWsw7XSXc4zd7stVh4D1k5HJZwlFeTFlMhnK47rTDRXzN1Y461lNP+mHSlnohjEWtgluxHmGVxolE8PZopmUA04ZzrNzBMGJv9YGcQLdcg5VXfGTAtvwqnqVtTTlY2qpn1HxsgWH3pAuSUmrLQHIoL7t2Bcbg1ouS19FJcOPzCt0bi2TQPLrML5SILUWzvBqn6BGuOyh4tGB2poatPUjnybT143WXeapgCYptwOjDiQ0bwQCw27Z7HyfLY6QifsZNl7c6USdU1DsgZpBf2ACEb47bfuAKXLf0hI3QRHSGMR3bb19J01U7Mwa4+94yS2L5o7NkV/16rAzNHE66FbDWl9KF+iU8L0SaFEZk4KtRd/4QsqXLVLqv940mRQICi+cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(86362001)(8676002)(6666004)(33656002)(4326008)(8936002)(9576002)(55016002)(478600001)(83380400001)(5660300002)(956004)(44832011)(9686003)(33716001)(52116002)(1076003)(38350700002)(38100700002)(316002)(2906002)(6916009)(6496006)(26005)(186003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N76qgRBKtPnBi+nwDNEtjYMWN2NBx09CxPVZkeZm775OeKV9abk8YDi6/Ixt?=
 =?us-ascii?Q?ekzVQrSdGbgZcl4OOg9FgDm8ByvSsSV831tNCijtZPszZ1h25R+ccHmVY2KJ?=
 =?us-ascii?Q?WiQ+6GkAvyJSqXAmswdVYydk5gRR5YQnyIYpgXPDcx0J8DKjzu0uguAcD/Qd?=
 =?us-ascii?Q?NATEn5Lg5ajfUBt9X06YQ/BLDWK2xuV4BBXyj9kT5EgZBdaJGfw4vOmgckGk?=
 =?us-ascii?Q?I9RCb52K0xxkiqjADbNx8aX3kgWDbxa/jcQiWypSEaGxQwLPjSOcQ1f7k+sq?=
 =?us-ascii?Q?Jx18t9CCSVyXCkEdRSvJpkRMWi2ak10I54YMENin8U2CPFt5to0uU7DFxy8c?=
 =?us-ascii?Q?HRUSGUGZTBK6bPgT55uEm8fP0Q/JdDLp/7PB+qz9RagnSsjhhopBWJeScO7k?=
 =?us-ascii?Q?dBSEFgm6q1jjar8Tu5eEyp0SP1/4435Pk5ZexIGpA9XLoyGRbwaTaqDtk2TW?=
 =?us-ascii?Q?IUhqI1+wpriKD1zGL58ETzlQhjEcU0qxiL8Sj/goBVjfq/ZHdb3XvOz0HOwz?=
 =?us-ascii?Q?8PggCu89nXU8ZU4j4qPSVclYxmsrsvz3goFuQU9m8p94xcB26yfw9+0qbXkK?=
 =?us-ascii?Q?ABVRa17QaoT22y0rEgVfWVyGpU1D4WNCHgmdBNv0w64A1QFiAmKZxVQRrlJj?=
 =?us-ascii?Q?EQrT5l76F7krO+5bIMxgK8ipcLzaQooojXdbqbztQtrHfJEsldAuRdZa5UN0?=
 =?us-ascii?Q?vaCGLc0VUfe+R5cMY29ElOxBel0Am2aZlUkDxOY/ter+7guX/9wbUe7n53GR?=
 =?us-ascii?Q?XGiROUye/ndThK2VXXIqFEA1E99xXiyOr60bfwnZjcF6DkySYh1spH4Nke9T?=
 =?us-ascii?Q?Q6W9quQalgcmSmbugF/P4hC6qsMv8M2IY+Z1CiSxo3VPNW9ucGPOn8VTFgvY?=
 =?us-ascii?Q?+uR1JM95m+8fGKY+fqAgq1jmMZ3g8mYvvVK8u0lNxEXI3r3XQnXgXqPkddty?=
 =?us-ascii?Q?KLt9dwYgFQqTJJRXchDgS1zNg9O1g0f3s0nMy8xxDP4ld4B2wi9bckhA8zHW?=
 =?us-ascii?Q?1VITqIsL+Xsv9lMwhSDr9YBUtcF5uSO9Uvi+CljONyJKa7Egwxaa7UDrBHDw?=
 =?us-ascii?Q?lWQTjqdbG7ijmEub5UPMfB5U5E5XjXpFIpIH2WY4w2XOaLaAooFnEDgyo8dg?=
 =?us-ascii?Q?LrIaUYoqgQNluxcAwpe9SoqwJdoYNo40YlIrw20A58v9EIwyedtleEU7p3xZ?=
 =?us-ascii?Q?AiawniItdYYHT/GydSGaTw7dxLy3DvlrDab7FMok9DbcJtI0XP9g7WEaru07?=
 =?us-ascii?Q?dcwRLpySqXs191aGfV/W7OaD7DWTmgTrjJSWvrqBlBXZvoNWydlEvfvZQqFM?=
 =?us-ascii?Q?//knlmbzai8OXzDO4Ky4HvgE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc11a13-8bf4-463e-906b-08d957276872
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 09:08:22.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGs64A15CBw/AfbXuOyoQbS0pSxE1KkHS785SV6YcotIcF4PmMeT3Lqq/o/2NJWaQjwR99w7IC5Rj8nirb2hpHkj+dUU/6s3MRyzxpBmsjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040045
X-Proofpoint-ORIG-GUID: 6mK99gnur24ouPbtzC7IPvePcMtlu2fX
X-Proofpoint-GUID: 6mK99gnur24ouPbtzC7IPvePcMtlu2fX
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ This is an ancient bug, but the bug is clear to see, but unfortunately
  it's probably less easy to fix.  - dan ]

Hello Upinder Malhi,

The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
driver" from Sep 10, 2013, leads to the following static checker
warning:

	fs/kernfs/dir.c:476 kernfs_drain()
	warn: sleeping in atomic context

drivers/infiniband/hw/usnic/usnic_ib_verbs.c
   190          if (usnic_ib_share_vf) {
   191                  /* Try to find resouces on a used vf which is in pd */
   192                  dev_list = usnic_uiom_get_dev_list(pd->umem_pd);
   193                  if (IS_ERR(dev_list))
   194                          return ERR_CAST(dev_list);
   195                  for (i = 0; dev_list[i]; i++) {
   196                          dev = dev_list[i];
   197                          vf = dev_get_drvdata(dev);
   198                          spin_lock(&vf->lock);
                                ^^^^^^^^^^^^^^^^^^^^^
We're holding a spin lock.

   199                          vnic = vf->vnic;
   200                          if (!usnic_vnic_check_room(vnic, res_spec)) {
   201                                  usnic_dbg("Found used vnic %s from %s\n",
   202                                                  dev_name(&us_ibdev->ib_dev.dev),
   203                                                  pci_name(usnic_vnic_get_pdev(
   204                                                                          vnic)));
   205                                  qp_grp = usnic_ib_qp_grp_create(us_ibdev->ufdev,
                                                 ^^^^^^^^^^^^^^^^^^^^^^
The create function calls usnic_ib_sysfs_qpn_add() which does a
kobject_init_and_add().  Unfortunately kobject allocations have many
sleeps inside them so it can't be done while holding a spinlock.

Same thing for the other usnic_ib_qp_grp_create() later on in the same
function.

   206                                                                  vf, pd,
   207                                                                  res_spec,
   208                                                                  trans_spec);
   209  
   210                                  spin_unlock(&vf->lock);
   211                                  goto qp_grp_check;
   212                          }
   213                          spin_unlock(&vf->lock);
   214  
   215                  }
   216                  usnic_uiom_free_dev_list(dev_list);
   217                  dev_list = NULL;
   218          }

regards,
dan carpenter

