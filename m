Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4A402997
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbhIGNVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 09:21:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344699AbhIGNVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 09:21:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187BnO6w026869;
        Tue, 7 Sep 2021 13:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=PXfe7w1pHL+KwTHdv2r33HLNW2H+hdlailrQY/zpHzM=;
 b=Uc0YkwuPO6eXBNwR1Ik1I3TCXHTDiwOB8fveZZzvpbvm8VqlV0wD4OT2Jzxg7K3M8l5N
 CAhNpRlu+vxC5lNAfEH4z2CWw2rNHW+H7gabk2w+ySk67cryNKbtoryZ2NXzI0hooWe5
 zb4N6h/QJ/ZwQxob3l7OPDzn9lUnHUGGFh5DYvuWtnRE5Ch/uRUv2LwlF5sek4jOGxZe
 l+Cjvgdw/AeoVfGBbxeJHoYaKUL3bNthAKbGXI3qaR1i/DNKg03pLMCsB4g3w5kDkh27
 jloFXW0ZWqdq74pWCy9SCADfQezOBwhoa/TYtMTHk9fyjViZo5rN2Z66xoev2mMkxTGT DA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=PXfe7w1pHL+KwTHdv2r33HLNW2H+hdlailrQY/zpHzM=;
 b=tAcI3IKB6ZZkXZNbZprqAwzi1i/Ch+SeRVuL/GbUljCpftEhtgqa+tlq72cVL9ZguSS/
 7+gy2C+t7rVQ8FDrvOcKE08zGgyxwxXjKjRHJY9VV02siWyDL3v41DkEE1D90Vmqtuzi
 iOyWMdN6Q1R1mdBEst9BmojedukIz/AykUlpRHGTXafzIWB6bIi8EqO2/JdE5Mi0VGPA
 dE3ESxXWS9lhNEierS5alTnshtYyesm8ubk8WGY4hmIyXwxle758W+x2eqY7iLjNGne+
 m5X4f8JIxJFwtOAUwZD6C8Tkr21gi6PIvmzl+8lfLSeVor+GyySJYaTm2RYTmzRwzkqz 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29hvpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 13:20:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187DGmg8050377;
        Tue, 7 Sep 2021 13:20:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3auwwwujdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 13:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5/pGPBr9+RpogF9aSrYKv/G/wb/lQBVK6jVABfC/zOytZxszUYtbqzJmEKYMOx2Xp1txkkRQPwDXK5ZJDwN+GYAOkyWjW3x5yglQh4vzI8PT1tBuzZUFxkl/HwrelyizPk0L5cZh6XGPoYyYNd7+E0g0fi1ZuZbd44oEIdVrtdsRkkwRaiugruS0EflZhKVTnW9WJ5BR96GByRwF6BpNppmFtNjzn6RFt2+EtbfMdvwjgRy0yMqfZaqGRKnjcRyeWaiGFeqL9/vYD5KKqLIOa8sQoYQXOoR159NgdIyhTNSMMNCXkChnjrZksCkhODqwOZ9iA5Fzkp8K8pCwvewTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PXfe7w1pHL+KwTHdv2r33HLNW2H+hdlailrQY/zpHzM=;
 b=Vxk7QTY/u4w9/89COJBId2CA8Qmw0RxyKi9O76XN5MzasiyLvwCXM9TkQs/NxTV086jB41Y+W6t9sq2Mf18fYIrmkz7Z1crArV4mvsR7qJCzbrUlbtVAN31qk9ICvoEm5enIhoTIF1lcmjFkEKVzOmBZewM1si6TJryEyTofDtegy3TR97WaMR0o8cW5zsEhl+FUKsn4cerBifEhQXsZN6xRYQP9XFB4SzZDlG7XPGm2y4wdklEpgD5M+N4OVTWUAPZi2VfjeI5Q5vCtnhSYTf+s9KCAvdIWVdTgnxOnlv6JHWMGaOdUDJU/BYAXs1NX1VXwZNaUkIgoRFI/FnyZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXfe7w1pHL+KwTHdv2r33HLNW2H+hdlailrQY/zpHzM=;
 b=cyE9uSnoR7pEs/7iFSVuGYUqJMcVwuej9IxJKEIFwNUin710L5rGdtf5eZ+wNZPzER8LLUGAxTnF6g/VFHdMlp36hJEPo5o5HBo79+fqU2W4v2s7xgNE6X4DzDmNV+/vPX8tRVY5XW8k6MKdbQ7akzyNWfW7YvHJHG4E6OaNBu0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5554.namprd10.prod.outlook.com
 (2603:10b6:303:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 13:19:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 13:19:57 +0000
Date:   Tue, 7 Sep 2021 16:19:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA: Globally allocate and release QP memory
Message-ID: <20210907131951.GA7450@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: PR3P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by PR3P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 13:19:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec7522e-27e0-43a1-c15e-08d97202303c
X-MS-TrafficTypeDiagnostic: CO6PR10MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5554CF7499ECBA75087A9D468ED39@CO6PR10MB5554.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5W1l0pLxrrTe9GkSrwW+qx4ls1fEsaOgoEim0UwnAZdl7pMLdNxFOtAiA8QiGMfth5uRuYp2Zjpvgnlfp40wJiZh/t3hrQGAqR/Vr0BeOhTpcvNMXW60nSJquCw/uokDrzgnkxK7KGkPp9H0edLjMmZ2nqzomvK+5SHEZEPLoIJPRHDyKqnDxbBo88Dpj0FHfrzOriAL4Cl6Xl09cGBXYGHh37aZgiBQDz+7qKh8iyxu7bjCy56EhjXSYDN3tLgdOc7LMHWrty7ge/M/bzZk8tkl/L9DzomddSfS/nrPZ5tBTlK8ZFGtFx75dzhmpr64bucuPgI+Q0NeXvSjCleFwBK9cHs8TK+V066fg1GMCYMqZXzeAfHcT2tQJNDw5WTmuNMtpGx6q3kygOf49gCNFfvYBFXiaf5fa6u4M0us0wkuLtC//c0NkregX5b4GISAtise6HWUqqr1hQ7WpiqfAPtXzWB7RddnT8rt2hwYD8pNpyjJzgIuEXCrGWn7O0/DdjOcFsotGIX7vE7Lh50ICLrSq/A4TjGCx1c9yuyYC1hNXoRu+EV5IzoqLu1qiYICc3aXw3P927To8aT9yMYFKokuMdS+nYI4J+XOwgiKeiQzXyBlX6qQSbUOtBFFMc9sgDLVY6HcsSicCiA69QVm/d8D7dvbNLdmtFPqJ60/6Jvr0GQwyNdZLTHazfL5NcfjQO9Zh5B4PlOHSHFaxAO2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(2906002)(55016002)(9686003)(4326008)(44832011)(33716001)(8676002)(26005)(9576002)(316002)(1076003)(33656002)(956004)(66476007)(66556008)(186003)(8936002)(66946007)(478600001)(83380400001)(86362001)(38100700002)(52116002)(5660300002)(38350700002)(6496006)(6666004)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZPtd2/MdC9Mfwf4FPgdaTk+jjV0CJ2vnt/gAiLm6dgrWI2kXgsK1iYq3uWOM?=
 =?us-ascii?Q?JyYpH+EKV+XmxFwxeMmnL8I4+cF3Sexejd1aDuQmMr9BpZYeA9kofG8C86hv?=
 =?us-ascii?Q?LlEsx3FbqV1b5V0Y/Gjc0j1lpwP46OcwylOe9r+wPtLb32EjUUCnkMt6WytV?=
 =?us-ascii?Q?4RJTXxaWViAvTYnBJU9ASzHmmOmsQbG6bedbBOxyIAAx8brHphIj7YQVJ2mO?=
 =?us-ascii?Q?CsUd67n+/PESx68d7POamVw0ob6zFAXdfEKGEcpaubB7Rtmq/6tQtd7qkjNG?=
 =?us-ascii?Q?YrTXQodfd3GJBstPA3sItec/p5eGBmBEpkTa3sUFUEWM/62mXtoBOiH7pzNQ?=
 =?us-ascii?Q?/GyVhvlAlrjeWdERTrRThGWqPZSEQFLVZP6EQhqHZLVnlxYPGcRg4w2nQZ4z?=
 =?us-ascii?Q?PkTQLABSxm9ehOe3yh0iyocmtmioHvEWyqDKc9X1WCCU23z1JgAoC3P4OLBY?=
 =?us-ascii?Q?T99TFNUucZGvOEJIlfrv8Y2WXYmy/Lr+/hsy1R0sFJH6gKmfHD7l3BWC6Vhx?=
 =?us-ascii?Q?uShx4uTIUkSwo0BH3BSxrKEsrueRoIyvnUJTIIS1+R1B78mF4ACHW5UHzBnu?=
 =?us-ascii?Q?xCn0Y0v5u//r2gpRjzcacMyYZB2ilqokc6obI3KVTc9Vbr9L0iNRUZZZayJ7?=
 =?us-ascii?Q?6HlyyH+K5brc9IVoE39SRvxYaU0NtlKM0S0tSL+Sthw2YXcNV6IKAjF9iOBT?=
 =?us-ascii?Q?eLK77VA9bu96FdFHmJezNMJnwcgHCdLhVMHweHw+BYxohTfyQmNJxsh4GDWF?=
 =?us-ascii?Q?Zi918sWlC0BPfJK8QE7xdnMUtjXvnejnx1EYf+ezl5kELCBwfjrNOxNm6ShK?=
 =?us-ascii?Q?EFHWfDyMJ5qUu/UDrR+8Z/hUS4w+IEWgYB0KRKzsU7fDoCz9Sf7I7G+yquj2?=
 =?us-ascii?Q?vUx4abtA1+p7d5iosOV28LcyQfNvQQK8M8ars2wsEoSpYRAaSVodSNC+4zZQ?=
 =?us-ascii?Q?Ka3Fhmb4NGA6VF70XbPY2lVYmo4QqoJFeZBhxelmIyjTCyIwACPHRPycBhWh?=
 =?us-ascii?Q?OcImWFKHPkAB9bgB8ikhVr3Yf26VAz57yvv8RFW021qwz0qyKUF8Aa9acV8M?=
 =?us-ascii?Q?BPaQ5BRPms0HRu7deewOH4wGkI4FCPeAZT/SDYwFbc4lWaYnf/himvOQfDoe?=
 =?us-ascii?Q?Hmd5b6RvJqp8kNg7Xfkv53jxHUMd50lk11M6KWB0Bz0Lb/a+XV+REw9FxlgX?=
 =?us-ascii?Q?SUYbPpEv73wH6RUB3Mc0yPMyPjkdqvv+pXDRcnqj6VQhpuaik8waZU5TnTtn?=
 =?us-ascii?Q?CQR1jodOIq1bPmuZQJ3X3ZR5c8MySmlTbkSPlXAGa4E24OUDEHt3ZWE4jQHJ?=
 =?us-ascii?Q?00UOLFqoAb0NNH9T1CML8jhj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec7522e-27e0-43a1-c15e-08d97202303c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 13:19:57.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu7ekwBDRCpfBJlNlQ7WhoM+uaeaG5WhpZQQxVM7qO90BYqnKwYQl82j+oYPGtTkMrXoS0S+iJXLmmj98lAhqLlOF22NWHesXgiBOT5Km/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070088
X-Proofpoint-ORIG-GUID: sWdMMHZWO3Ag97DOdZmjTUWV2voGSk5i
X-Proofpoint-GUID: sWdMMHZWO3Ag97DOdZmjTUWV2voGSk5i
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon Romanovsky,

The patch 514aee660df4: "RDMA: Globally allocate and release QP
memory" from Jul 23, 2021, leads to the following
Smatch static checker warning:

	lib/kobject.c:289 kobject_set_name_vargs()
	warn: sleeping in atomic context

lib/kobject.c
    281 int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
    282                                   va_list vargs)
    283 {
    284         const char *s;
    285 
    286         if (kobj->name && !fmt)
    287                 return 0;
    288 
--> 289         s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
    290         if (!s)
    291                 return -ENOMEM;
    292 
    293         /*
    294          * ewww... some of these buggers have '/' in the name ... If
    295          * that's the case, we need to make sure we have an actual
    296          * allocated copy to modify, since kvasprintf_const may have
    297          * returned something from .rodata.
    298          */
    299         if (strchr(s, '/')) {
    300                 char *t;
    301 
    302                 t = kstrdup(s, GFP_KERNEL);
    303                 kfree_const(s);
    304                 if (!t)
    305                         return -ENOMEM;
    306                 strreplace(t, '/', '!');
    307                 s = t;
    308         }
    309         kfree_const(kobj->name);
    310         kobj->name = s;
    311 
    312         return 0;
    313 }

The call tree is:

find_free_vf_and_create_qp_grp() <- disables preempt
-> usnic_ib_qp_grp_create()
   -> usnic_ib_sysfs_qpn_add()
      -> kobject_init_and_add()
         -> kobject_add_varg()
            -> kobject_set_name_vargs()

drivers/infiniband/hw/usnic/usnic_ib_verbs.c
   196                  for (i = 0; dev_list[i]; i++) {
   197                          dev = dev_list[i];
   198                          vf = dev_get_drvdata(dev);
   199                          spin_lock(&vf->lock);
                                ^^^^^^^^^^^^^^^^^^^^^
Takes a lock.

   200                          vnic = vf->vnic;
   201                          if (!usnic_vnic_check_room(vnic, res_spec)) {
   202                                  usnic_dbg("Found used vnic %s from %s\n",
   203                                                  dev_name(&us_ibdev->ib_dev.dev),
   204                                                  pci_name(usnic_vnic_get_pdev(
   205                                                                          vnic)));
   206                                  ret = usnic_ib_qp_grp_create(qp_grp,
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This used to be ATOMIC but now there is an allocation hidden deeply
in the kobject code.

   207                                                               us_ibdev->ufdev,
   208                                                               vf, pd, res_spec,
   209                                                               trans_spec);
   210  
   211                                  spin_unlock(&vf->lock);
   212                                  goto qp_grp_check;
   213                          }
   214                          spin_unlock(&vf->lock);
   215  
   216                  }
   217                  usnic_uiom_free_dev_list(dev_list);
   218                  dev_list = NULL;
   219          }
   220  
   221          /* Try to find resources on an unused vf */
   222          list_for_each_entry(vf, &us_ibdev->vf_dev_list, link) {
   223                  spin_lock(&vf->lock);
                        ^^^^^^^^^^^^^^^^^^^^

   224                  vnic = vf->vnic;
   225                  if (vf->qp_grp_ref_cnt == 0 &&
   226                      usnic_vnic_check_room(vnic, res_spec) == 0) {
   227                          ret = usnic_ib_qp_grp_create(qp_grp, us_ibdev->ufdev,
                                      ^^^^^^^^^^^^^^^^^^^^^^
Same thing.

   228                                                       vf, pd, res_spec,
   229                                                       trans_spec);
   230  
   231                          spin_unlock(&vf->lock);
   232                          goto qp_grp_check;
   233                  }
   234                  spin_unlock(&vf->lock);
   235          }
   236  
   237          usnic_info("No free qp grp found on %s\n",

regards,
dan carpenter
