Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F54CD549
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiCDNiB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiCDNhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 08:37:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66191B84D9
        for <linux-rdma@vger.kernel.org>; Fri,  4 Mar 2022 05:37:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224AHvLF019453;
        Fri, 4 Mar 2022 13:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=RaXhVMoVy2PzunHq3HI6mYxGaBGrd2sfxOZbKlOgN3s=;
 b=WooaFdJuvk21+qzhiyU+lFzzbVOJK8FL/K4LsaTk4wrfXiGSF1K2xkcSI4Cx6syjq4xW
 k05OhObrPSCn6p4B4gvBUMv4gx9tgLuCqUrGnk4fyBgIFZ7ydY8RrzdNUHX4Ea5bn/vr
 EB9u+/9yfvKCfjflO3eKbM9WVqCy/VEUvysmCR4byZWbJ882dB27PQpw89ilhw98AkfC
 u/z9tyTGOfsVq8nHE74lwTeRoCvwdBm2cv9nQ4vr8IoH2BR7VolVa+BoNxnvGJq04mHm
 01M/bGinGWM5kRfaCqqtCR751WyO7y+JGamqKfpfkq7WvRKrhYAFTWwKDxsq4YsHFVk2 KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hrssw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 13:37:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224DawTx139107;
        Fri, 4 Mar 2022 13:37:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3ek4j8u8d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 13:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWMxjBULthEEnPcQnwGlmfeBOqjO6lcWKdklMb39baRcpYvuxFkpXWL8M6mpr7TrUm7WcLAT9aip/FqRqU5OxZ/cEZJL3iS1LB/SeW0BKFnuNa4I9T6lP3T8tkAyWydNdsztyWKliHLbNX1YHtYPDcJmlaj6Ab+yawZ/P+0YQat+vdEZGjMAK2AMj7Q/ILQnU1LON4PWxCph1wX25IWiqCZrEkCaYTm4WtVU2Di/nLlTL/GKBTuyQnbkoZdR2u4By2WDouvhMJDNeFbWKdZO1by/MUYUVrE7bGNf8I6t7QCklZZ3t5UCEEn7cqz1HUQ38fQWTeMGi6L0gclSG2cz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaXhVMoVy2PzunHq3HI6mYxGaBGrd2sfxOZbKlOgN3s=;
 b=BbvXR/9S/qZsM8FsPB4qhWud0LHyB7Z7mz2ylITIoDqMmpocBUUM7CNoaKle/5HUHHgelRyaAgvdfKfHGGh/TfCi/yPj4g4MsEo99SbnLEfo7Zwig3B99UNGK/tmU+/D1nXp9rfmq0rs/sAxeCXKE6uKjJME8HGoIUYqqR0EtrJhabbQNmhr33rJZYSJJjovTSAg7YK/A0LeXju9boG/ywaVtl7KpsCw0ha61zej6WIjD7LlPAjA6+aMChaKxFSsHWhvssTTYrcmGIUzyTFb49PWMeJJZtsAgEWbQfEoxY4pLaZALrzvgxKGhEBsvPXgSnSncjwdAfov1AFBLaGxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaXhVMoVy2PzunHq3HI6mYxGaBGrd2sfxOZbKlOgN3s=;
 b=hyd0QY+7PwxbD4620oSlw7W6zpcrCNNFuWXLVJWtFKAeCBSU/bB1Ol3ulo/W3s+WR4WoFbfUFCHsdD5+MxPr1RQ+kE6EVOZ8iAZIhO+P3axcUhiFStmpBZJd3d80J1AfKpjmjEPN84HEsBx//s1bs2VzmVT1FfmehcrR19949VM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4350.namprd10.prod.outlook.com
 (2603:10b6:208:1da::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 13:37:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Fri, 4 Mar 2022
 13:37:01 +0000
Date:   Fri, 4 Mar 2022 16:36:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kaike.wan@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/hfi1: TID RDMA RcvArray programming and TID
 allocation
Message-ID: <20220304133650.GA32617@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0180.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96f7c664-d554-4676-a044-08d9fde41041
X-MS-TrafficTypeDiagnostic: MN2PR10MB4350:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB43503AA83C559A613EF299A08E059@MN2PR10MB4350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOtB8I8zovZaHTK0hyTfK5lILF1p5s3rC6UdFaBpLK5uwPabQMZVaNtA2uLMPjKhK3TeUhH8vM9F4CAjKNmavICD7LjTZ/IvohfmzDa/52rFWHZ6H3uWVVtbuy1g3W/G/nSC6ID7T8iJO3VXLZs/eiPHUn/zYKfFxUDkrxN8vHD5tOB0kerpSX44ioRaSQKm04d7Phq2yLLdYiR6HzjCJCnSK/MKAzKNZs2C8Jc3Fdgd2swm5Rxy29LzTFA6k53BCYa2pB3Pv89Tuqujn1BHVKI3FkRKO1UHNF8VQNN1WrrUjBW84ohFUq74y4edWBorcgfp1dZVwE5a7znzU/vKmwDA2RMt3nGXfUJbQ0emmFYgwm/ig8OTVTEydujJPaoqeNrKtz+PUhcW+Sk5S/fyw+43LbL0nziM16m+J+WQDFEvt8kn8Ghns1g3GUo6pBhMNEqdkmQ/JIm8KiQ5XOB9EwvY7vq7pPTq1wGdbeo2XN0oNqCGhtvnoJXtHc4Z+xnKqZAERegTczEbPcDTGqXqO3hLQJYNAAC/N+DQbKtrgdgP3dWbKavL1oxo1XGDjzwpO8PAUa2EW/b4YVn9eqawbmBKA1Yx91nWP/JMVfuXzvrmrHXrjHqJf2PlCL1z+swECgceqMixb4zq5C3nxLBE2vmZFud+29a6eiMCCIXaycUJuuuriS5bRbvNQ/pFM3DRuprfB86BSPpTMl9W8+b3Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(66476007)(66556008)(8676002)(66946007)(6486002)(6916009)(4326008)(86362001)(38100700002)(38350700002)(33656002)(508600001)(1076003)(6666004)(2906002)(186003)(83380400001)(5660300002)(52116002)(26005)(9686003)(8936002)(6512007)(44832011)(6506007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlNw1N0uHoeBquFp0WlCvLr+hKpHVLVAFeQgSmavHNXDWaw0s2waty8YL8KL?=
 =?us-ascii?Q?Wimx8AM+2owJ2a5UhIzcxXsmhn/MwwRQ/wSvV07+aGJFyYTp+iq+4LXkVlJh?=
 =?us-ascii?Q?vBjy3Ml/56/3Qln5auZ/vG4A2wVs1pckKNKLo3eAeI0KIkZfwOcChNXFSo2O?=
 =?us-ascii?Q?8VdVVm1F8HTQ7DIHsgwWgcOBCYQUac9bDBPu4BCsXxUG2N+9HNn5Aolq953J?=
 =?us-ascii?Q?q/JkuJRoQkUxsb0znAYYqJRVBahB2dDbdNCz21BuVOC/443qO/64QZumV4JT?=
 =?us-ascii?Q?zoQg/2IMR5mN6Z2WV+yg3A+vO6T1wHEQNPMS95qtYeH22gNg0oDyTbN52KQ7?=
 =?us-ascii?Q?Dqj+VlIK1zFDEEAcNkXIhN6L2tCarxh6n4xQs+pomDNz3X1qKoKjeD6vdJgP?=
 =?us-ascii?Q?feseoGMYnG5OOCwd8F9DefFpfXBsqNrhzpX5GZ896s/x3hrn87bv+PO/YjFW?=
 =?us-ascii?Q?MC7SmrhWmSgTpAWjiUuM5CWeVUmJGdSaFc64ld2GU5++NsgjWW9z5Iq70Rtp?=
 =?us-ascii?Q?32q1UAszgavPtEIIrvdUKjXtGl7ZTeTP9aRxP94mYIF+Qc+eu188rVwG28ms?=
 =?us-ascii?Q?dsRbjBma0GHlafVPyf3HNLUSc+Z7O6iTn7tFQJKdbm0uoetNfTlIRFcu5ms6?=
 =?us-ascii?Q?YuTeYcBL8rSSpOiecr1kNVoOMwP9d7+anyH5N58E0S6CLhN5KNU+5Nrukeay?=
 =?us-ascii?Q?kKxE+qEQdB/3BcZNY/K97Jq+gsx8LyKQFcpu0RLy2uf63RneMtlcmeZPwG6r?=
 =?us-ascii?Q?mbOCp0n/ElCVF3KIMJrlCDgh+VKacz0D6Sk8U/cGj+IiIpoODy6hIMFHsIp/?=
 =?us-ascii?Q?97hFO8Ff5gGBCphX2nZCrhLIUeJc452B7U6LeAFZX8S1hypnEMcqcpgAp621?=
 =?us-ascii?Q?S9lmFaexPIvH9cwPLI/Kyse5MDgw6mCUCteg/gqVIaqS49gaxMomWR/VL9hh?=
 =?us-ascii?Q?kg0DzN76LyPMai+Srye3sXQNBFq/0mcirnIVBxMntZ8bf0nIv9oogXPwa5kO?=
 =?us-ascii?Q?h8aybZoLSlr3w8CYwWkMPoOsXxXoH/6Ga5yo7ftKUiqsd4JosikaGrbqrBbc?=
 =?us-ascii?Q?/1Sga+lsBLhP/7xbVibku45dGyVf42ecgFBHZsgzD6XdJJ8xbQAz+VemLr2D?=
 =?us-ascii?Q?LNRrU6K7oMV0GPf3XfWFUx7lukY2feHtPmbjMMG8zy05Kob73L8YDam3ougm?=
 =?us-ascii?Q?lS4cbjGKvnmW2QvM31ysqUcZ7P0WJcM5p5NEbSqC16jNgJNYeLcpBqbp/GbV?=
 =?us-ascii?Q?eybgPTaAxFVLZ5p7ddlzDwm+WIV7FM7Gfm46cvjrqKYjta5BiwkKcZT1aqL2?=
 =?us-ascii?Q?o+aWDELHN+5o/gHjyLJdp28rXEMe3MAcVKHH+VYeNja0KV8WxbYknMdR0ed3?=
 =?us-ascii?Q?M7ewKGa4Wx9zB3o9QI4gnzAl2huVZKXr57DWYsIXQawjaYMb+tvL6leT+aLi?=
 =?us-ascii?Q?rdsIj6UOaW2/3Dl663+Y6pjHo8D/GFj3j8rmk2dvOHvmUK7gk2EiG+uxks43?=
 =?us-ascii?Q?obNy6ui+cdZX3RnPGwewTXbCzuCVtRYMzQlE9HHpA/9tp9dcIjfopwG2RVxH?=
 =?us-ascii?Q?/dz8LPnsxVndkAn2IWdXa0GDp0dZ6yZ7VISR4hQuiGcy9oBN9Riv4O0Yt3Bj?=
 =?us-ascii?Q?BgSNqEkUUzvKgo6gbKSrtStS1CzBwmgaFCurEH5bzTr5CYb8TuHm/7Ss8HqJ?=
 =?us-ascii?Q?2iWWPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7c664-d554-4676-a044-08d9fde41041
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 13:37:01.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EItOI/xCfSwqfY7zvVh+qSeVjxiRbSaPiuS6oP1RcdRR7+JX6Q6wgScPD7e58j1YyMqPEwj14rjF3dLfNS9PgsqLIK8fw9igdNCweIvvPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=962
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040074
X-Proofpoint-GUID: n5q8U_edeaC4fxy_562ilsXAbaTrSxSH
X-Proofpoint-ORIG-GUID: n5q8U_edeaC4fxy_562ilsXAbaTrSxSH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Kaike Wan,

The patch 838b6fd2d9ca: "IB/hfi1: TID RDMA RcvArray programming and
TID allocation" from Jan 23, 2019, leads to the following Smatch
static checker warning:

	drivers/infiniband/hw/hfi1/tid_rdma.c:1280 kern_alloc_tids()
	warn: iterator used outside loop: 'group'

drivers/infiniband/hw/hfi1/tid_rdma.c
    1237 static int kern_alloc_tids(struct tid_rdma_flow *flow)
    1238 {
    1239         struct hfi1_ctxtdata *rcd = flow->req->rcd;
    1240         struct hfi1_devdata *dd = rcd->dd;
    1241         u32 ngroups, pageidx = 0;
    1242         struct tid_group *group = NULL, *used;
                                   ^^^^^^^^^^^^
"group" is NULL here.

    1243         u8 use;
    1244 
    1245         flow->tnode_cnt = 0;
    1246         ngroups = flow->npagesets / dd->rcv_entries.group_size;
    1247         if (!ngroups)
    1248                 goto used_list;

"group" is still NULL on this error path.

    1249 
    1250         /* First look at complete groups */
    1251         list_for_each_entry(group,  &rcd->tid_group_list.list, list) {
    1252                 kern_add_tid_node(flow, rcd, "complete groups", group,
    1253                                   group->size);
    1254 
    1255                 pageidx += group->size;
    1256                 if (!--ngroups)
    1257                         break;
    1258         }

If we do not hit the break statement then "group" points to invalid
memory.

    1259 
    1260         if (pageidx >= flow->npagesets)
    1261                 goto ok;
    1262 
    1263 used_list:
    1264         /* Now look at partially used groups */
    1265         list_for_each_entry(used, &rcd->tid_used_list.list, list) {
    1266                 use = min_t(u32, flow->npagesets - pageidx,
    1267                             used->size - used->used);
    1268                 kern_add_tid_node(flow, rcd, "used groups", used, use);
    1269 
    1270                 pageidx += use;
    1271                 if (pageidx >= flow->npagesets)
    1272                         goto ok;
    1273         }
    1274 
    1275         /*
    1276          * Look again at a complete group, continuing from where we left.
    1277          * However, if we are at the head, we have reached the end of the
    1278          * complete groups list from the first loop above
    1279          */
--> 1280         if (group && &group->list == &rcd->tid_group_list.list)

Okay.  We could silence this warning and clean up the code by writing

	if (list_entry_is_head(group, &rcd->tid_group_list.list, list))
		goto bail_eagain;

But what about if "group" is NULL?  Perhaps this should be:

	if (!group || list_entry_is_head(group, &rcd->tid_group_list.list, list))
		goto bail_eagain;

Because otherwise the code will crash.  See below.

    1281                 goto bail_eagain;
    1282         group = list_prepare_entry(group, &rcd->tid_group_list.list,
    1283                                    list);

Then group would still be NULL here.

    1284         if (list_is_last(&group->list, &rcd->tid_group_list.list))
    1285                 goto bail_eagain;
    1286         group = list_next_entry(group, list);

Now group points to invalid memory

    1287         use = min_t(u32, flow->npagesets - pageidx, group->size);
                                                             ^^^^^^^^^^^
And this dereference will crash

    1288         kern_add_tid_node(flow, rcd, "complete continue", group, use);
    1289         pageidx += use;
    1290         if (pageidx >= flow->npagesets)
    1291                 goto ok;
    1292 bail_eagain:
    1293         trace_hfi1_msg_alloc_tids(flow->req->qp, " insufficient tids: needed ",
    1294                                   (u64)flow->npagesets);
    1295         return -EAGAIN;
    1296 ok:
    1297         return 0;
    1298 }

regards,
dan carpenter
