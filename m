Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A63D8CF2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhG1Ln6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 07:43:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47100 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232165AbhG1Ln5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 07:43:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SBggCN020126;
        Wed, 28 Jul 2021 11:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SEJzTlkMrZgFQZRCHG9YZJ5vFamgTey7WoiZGo0zzqI=;
 b=KxIAz+vRD8NSFYR52ZgRCL2GhW0ZweIe9jyLtT0uW1mjrHfor8JG4WDTndIJiHbK7gZ1
 ZiENrdRcsi3Rnlxo2plMxVKUVoSX3OtYfP2b0JlNxjYrbXuVn0zdoJCMOnvr4ImYC67j
 30rGL+7xfXSd2NaUyH3F9fscSJ2miWAQyefnROGsPfNsCAsRBl2e3YLMNgC62G6lQ+aR
 bP8e474ytdGKZUsgJrSVbQuQH98K0JKyXVlgKlwEA/QqBTs3YnMgsqrI2/7TY/U9z/XW
 6C3hvIAAnuYnEaWzZAhAftMWxtNa1Z9eh0Q/9qO02vPUWdsWl5Np6u+JOF40i3U0KY5g Ug== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=SEJzTlkMrZgFQZRCHG9YZJ5vFamgTey7WoiZGo0zzqI=;
 b=N6/Kz8KOGOSqbxUW9ZWhm99OXxl7+YQddSJQ72KvtQxQKea2UiL3rMhFVP3gCCdk7gDG
 +y4Oek1V5L2GiFtSSzbiIvQW/cjwwBMZFktYFIvAmPTXxrNRGGG87zu/o8Tcq0ylH1Ri
 k87pT02O6HfoODVkvxJgJlQT3fGE5oaUZ1/xdPoxJW35ZaOfhwKfriiLbBHIDzMToXh/
 iaW/qk+ljPvw402HpdwX5OL3LaXLFDKsI90qkmBBHabGKlRWyD3aog7U5AhJOoYspty1
 JQyxqQcbHQft9+fuj3OdCUprXkklwXWD0NXEgcYmRwqRSSQ8ydcAFJD9Yp6YORi/mhG+ 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2353c78e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 11:43:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16SBdYbu146965;
        Wed, 28 Jul 2021 11:43:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3a234a0djc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 11:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0tXLcRPVe7xOEHUk0pE8WtENuGuYQKc4e7XMHxgyRlsj7M99UrQBRcdlHpHaMQ3tykGSTMChzsQK2K4B2dZK/cBB78c0BErQoGT7A7uX7z+42MwTd9XNtj5igQBXYB56Pg7k7r3OPTgViMepwUN6MENApya1lXxCGntQA6EuDJ0mK6iFmXMm+iEWJSwHQNL4C5suK4AqjNAV8nqtJZGNGn/9PTBSvDlbbvDis1/++LZGb4giBXNUooxgYbF88le3tS9zlMc5e+FlPCrXmEEXgIJhwhftR0IAR58BVsE5zaOP2Plg/1opVCgBnDk3JijhIdbi6Jz2eOMmJ7S7cpITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEJzTlkMrZgFQZRCHG9YZJ5vFamgTey7WoiZGo0zzqI=;
 b=PQ3F0UDr4F5uuMCuWPjiVPNBnyovFUacIpRLIZFJIKcMP+t0MSHz1+i/e5zj6XRSUzUSS+GkNvjq+givQrH77x3uC/YHeUCQHvftZc3cR367mEpCZXsSb721HdWa0b+e8wHUQtIq0ajOQy/nJvsOM30O8uSNOJEq4l380JJ2lGM4thdQ6OmvDsqliXxk6N5N/XZ93U8gExqIgSLWMaP8NgkinIkNH+TiB5sIdlk7VnMz08kkfeYVqZDmH47H+Abd2npc8yAP7NPkkX5wNEywIZ6NmJxtR/wHfTNUPYx2+KtavzVWcNFtrjgm/Vk1fBwZ/qawJMbzcn/c1AFa+EVk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEJzTlkMrZgFQZRCHG9YZJ5vFamgTey7WoiZGo0zzqI=;
 b=o+AFp2TYQ5Yx5As/9FdoFRN4R5lSLUGJyDX0NJt23Q973xFB3bPtqFImEoPvDCoVy+6oHM0TXq6/sJymo1PJU3vqQ5q/8Yx6sVzn3LejyaAUkSQ72Nu+0Kb2+IULleYOmesWia+olsRKDXpv/hZs+JOEA3T51KtlNvDYq8Smkuo=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 11:43:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 11:43:45 +0000
Date:   Wed, 28 Jul 2021 14:43:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     liuyixian@huawei.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/hns: Optimize cmd init and mode selection for hip08
Message-ID: <20210728114334.GA5071@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Wed, 28 Jul 2021 11:43:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d6d89b-78eb-4d94-a9b9-08d951bcf4fc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46916C3CAB630F744B77C2DC8EEA9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2Vbcik1Ka1ZQIcFH5HNYLVrqdOY2vpjPnutVsaQkpxPkXYugzveJom6p7IS6pOCWKfJjzlByBnbUEgxuvKibPE6Pv/vANlLImdVG5HsRpXNVBgI4XfO0UF/EbMeivx82R8Z1QoCFJ1Ip1aGVZynbgIdy2yJiTcc/+gm53ZbyAwoK6L/OVPOXvO2ujhO1emZUM4OdMPX65RQffqIlxA1lZeaAIDBzcjt9oy+Vnno1Bi4SCQAK+u3RLV5rwdVkK29VrJCAJw+rBZm0HyIus9v9+XvTqMi3BOP0cG/ZTnP88zWlvhVj8lKybkk1sTaYqPDYUb3XLM18YjlxLvKyP7lzgymWO246RRgvuVF/2/pYEQqwgZwWxEDadUVT0NJ+qLgeM3WO2+Ss8OuaNzfA/HpVYIESn+9EeIPaYZginKH9nmq8eY4MLBZ/Spd/xRupBNPPaEQERzg9Vn4cjqVArjrHIIpjimgJAVVJDDAiW5cnKYWUVXj2MM4Sp+ItsyFKVA14Oaq8vUc0Woe1N95BzxStxVqalsPVc/r5WI0f+Nal5LT7r1AQxUm35jMD1nZgcCZ1Ry1CgWJV5IbIB/Bnk/wEtT4+PrQQSRNen/Zvd4Vsh8URelpWZWdawEN3/BV488lnv4+xkHBUY5UFsN9PpGJmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(55016002)(86362001)(33656002)(1076003)(6916009)(9686003)(8676002)(38100700002)(6666004)(52116002)(186003)(508600001)(44832011)(66476007)(66556008)(316002)(66946007)(8936002)(6496006)(5660300002)(83380400001)(2906002)(9576002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EzzfCs/DXjNaub39PGWzzkEhQCw5237iuhotKQu3KxBo9PMn71+UVcmNjoa?=
 =?us-ascii?Q?cV+kPWqHzYAmom0W52LJZndPqw/GKh4yf1i3V8C1jeLtM2kNaLwOOty5aJy1?=
 =?us-ascii?Q?lJ0nrCUEskJDX+EoE6xsHjxtQGtH/cyAEeBxEvXrkdJkkVkLvvBUgjiXnwV8?=
 =?us-ascii?Q?a75XKXDsN4APYCMoP5FjqrQL5ebXlQ0prYjATcrXUI252Yy63SKB3BevYxNq?=
 =?us-ascii?Q?Dlh+5cBjavUTgaWzSCB8riWrN0EIy/TgtnA6GmaLQfNwgSV+mhKPP4aeznrQ?=
 =?us-ascii?Q?Kt6Cdro679Zzn9rMplfFVEFL3oMnEp5UzEyG2bebkOPyPOSSH8JPg2IV2Oyr?=
 =?us-ascii?Q?n5PXQVBmLR36SW+EPmv0BaKzL9RNcamCOKePpVLmDnFiu4TW4d6RFS+os0yW?=
 =?us-ascii?Q?8TZXA591d0hYP+hzTDdTCWIYyB+NmunTuMEZ/D4WOjUEKyrZrcOyKfvMSFYu?=
 =?us-ascii?Q?uCR1ccJ2OVUTcCYJw8aZjSzv+Rc1JvfyW/7tAanSJsvxRVlGGdd4vG+dCQbA?=
 =?us-ascii?Q?A8ORhPxTTt9DQOucjBshjyC3q3cKwkbFWr/TejbMZRei5LjBrlrrpQjCmJ7o?=
 =?us-ascii?Q?wC9bjVC9bSdhB4XJ5lzc1UDqcAmG1WvqHZX5HqCR1pyENgbn08ZhhGOIO670?=
 =?us-ascii?Q?G51kHz+ClZO+9OJ01z4WFhH9NgANWDWZ9HzwBK9YKdnK/YapzUZ42EvmChzK?=
 =?us-ascii?Q?CEEhSflaCei8vXLvSjQYl5IM0sVzBaac3G+4FnnT6htwK8jam43kvdXIxcBJ?=
 =?us-ascii?Q?ojD45+Sx81b86rAQFNx4M1TO7BBdB4sA4jYByg7HTV8ZP0zj/M/DU+XQGCBc?=
 =?us-ascii?Q?sb+YzDkFpmhrQIlpWnx59lovKWp0yyO2kjkGVR2KVCIbeeg9NyvBtxXO+RHX?=
 =?us-ascii?Q?Hmuu/uZh3CK7SNHbwhcI+czMm+miBPMmPNCEfOO4FgN/ATZVlq9Z4T3gg5ye?=
 =?us-ascii?Q?0o0KBYG1kfGcFpLYK0giPlNtzZBaDmnDTNsLCRWu+snBc4Mcb3g6idQit1cY?=
 =?us-ascii?Q?cuc3KL0L89yF2EAaqJ1aovmaznnhH87DRIIY6U3Zb37lJsOKMai6HnSvq8Pp?=
 =?us-ascii?Q?jA7e6B3euYbFsyqfkq1mtrxj2AQ2xrYntq4IR7b5EtmH2Pc94JCQP+vRySaR?=
 =?us-ascii?Q?oEhw1HveNttK4OosFV7ig+ihqCZJzM31r61tGeJ0EnqtAIt1m/m+A66St2cx?=
 =?us-ascii?Q?FFAwXZvv03SJY+xKbkwG6ns5iYQ/Tb7PP0Nu7cFSSZnHBJ9JRdNrRWc1o6fx?=
 =?us-ascii?Q?wovmQNqRZp8G108Qxobd2Wx4hyR+rdhkNQDr0TmhUU3v2hLvYSBZKlHq6u8J?=
 =?us-ascii?Q?cLsA/iIC0VcvF+TbsGj0TcC+zkVKkp+C2tPxln0emvYdDClm/+MCAAh+fmWz?=
 =?us-ascii?Q?tbiVkiw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d6d89b-78eb-4d94-a9b9-08d951bcf4fc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:43:45.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKbOFVtpG9xiIU8ZC885LdcFRzRm5TD/2XumaNuH4VlgV9VzNxh6cCtPkb5xLsmIHoFtzyZW8IDIi590PI5ZTsbRdwohoaMepXO6Lmqq5Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=937 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280065
X-Proofpoint-GUID: RN7VfknqoflP7WaQ7dJR2xUnSW-Ue9mN
X-Proofpoint-ORIG-GUID: RN7VfknqoflP7WaQ7dJR2xUnSW-Ue9mN
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Yixian Liu,

The patch 3d50503b3b33: "RDMA/hns: Optimize cmd init and mode
selection for hip08" from Aug 29, 2019, leads to the following static
checker warning:

	drivers/infiniband/hw/hns/hns_roce_main.c:926 hns_roce_init()
	error: double unlocked '&hr_dev->cmd.poll_sem' (orig line 879)

drivers/infiniband/hw/hns/hns_roce_main.c
    833 int hns_roce_init(struct hns_roce_dev *hr_dev)
    834 {
    835 	struct device *dev = hr_dev->dev;
    836 	int ret;
    837 
    838 	if (hr_dev->hw->reset) {
    839 		ret = hr_dev->hw->reset(hr_dev, true);
    840 		if (ret) {
    841 			dev_err(dev, "Reset RoCE engine failed!\n");
    842 			return ret;
    843 		}
    844 	}
    845 	hr_dev->is_reset = false;
    846 
    847 	if (hr_dev->hw->cmq_init) {
    848 		ret = hr_dev->hw->cmq_init(hr_dev);
    849 		if (ret) {
    850 			dev_err(dev, "Init RoCE Command Queue failed!\n");
    851 			goto error_failed_cmq_init;
    852 		}
    853 	}
    854 
    855 	ret = hr_dev->hw->hw_profile(hr_dev);
    856 	if (ret) {
    857 		dev_err(dev, "Get RoCE engine profile failed!\n");
    858 		goto error_failed_cmd_init;
    859 	}
    860 
    861 	ret = hns_roce_cmd_init(hr_dev);
    862 	if (ret) {
    863 		dev_err(dev, "cmd init failed!\n");
    864 		goto error_failed_cmd_init;
    865 	}
    866 
    867 	/* EQ depends on poll mode, event mode depends on EQ */
    868 	ret = hr_dev->hw->init_eq(hr_dev);
    869 	if (ret) {
    870 		dev_err(dev, "eq init failed!\n");
    871 		goto error_failed_eq_table;
    872 	}
    873 
    874 	if (hr_dev->cmd_mod) {
    875 		ret = hns_roce_cmd_use_events(hr_dev);

If hns_roce_cmd_use_events() fails then that means we haven't taken the
semaphore.

    876 		if (ret) {
    877 			dev_warn(dev,
    878 				 "Cmd event  mode failed, set back to poll!\n");
    879 			hns_roce_cmd_use_polling(hr_dev);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This releases a semaphore but we are not holding it.


    880 		}
    881 	}
    882 
    883 	ret = hns_roce_init_hem(hr_dev);
    884 	if (ret) {
    885 		dev_err(dev, "init HEM(Hardware Entry Memory) failed!\n");
    886 		goto error_failed_init_hem;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
Let's assume we hit this goto

    887 	}
    888 
    889 	ret = hns_roce_setup_hca(hr_dev);
    890 	if (ret) {
    891 		dev_err(dev, "setup hca failed!\n");
    892 		goto error_failed_setup_hca;
    893 	}
    894 
    895 	if (hr_dev->hw->hw_init) {
    896 		ret = hr_dev->hw->hw_init(hr_dev);
    897 		if (ret) {
    898 			dev_err(dev, "hw_init failed!\n");
    899 			goto error_failed_engine_init;
    900 		}
    901 	}
    902 
    903 	INIT_LIST_HEAD(&hr_dev->qp_list);
    904 	spin_lock_init(&hr_dev->qp_list_lock);
    905 	INIT_LIST_HEAD(&hr_dev->dip_list);
    906 	spin_lock_init(&hr_dev->dip_list_lock);
    907 
    908 	ret = hns_roce_register_device(hr_dev);
    909 	if (ret)
    910 		goto error_failed_register_device;
    911 
    912 	return 0;
    913 
    914 error_failed_register_device:
    915 	if (hr_dev->hw->hw_exit)
    916 		hr_dev->hw->hw_exit(hr_dev);
    917 
    918 error_failed_engine_init:
    919 	hns_roce_cleanup_bitmap(hr_dev);
    920 
    921 error_failed_setup_hca:
    922 	hns_roce_cleanup_hem(hr_dev);
    923 
    924 error_failed_init_hem:
    925 	if (hr_dev->cmd_mod)
--> 926 		hns_roce_cmd_use_polling(hr_dev);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This will release the semaphore a second time again.

    927 	hr_dev->hw->cleanup_eq(hr_dev);
    928 
    929 error_failed_eq_table:
    930 	hns_roce_cmd_cleanup(hr_dev);
    931 
    932 error_failed_cmd_init:
    933 	if (hr_dev->hw->cmq_exit)
    934 		hr_dev->hw->cmq_exit(hr_dev);
    935 
    936 error_failed_cmq_init:
    937 	if (hr_dev->hw->reset) {
    938 		if (hr_dev->hw->reset(hr_dev, false))
    939 			dev_err(dev, "Dereset RoCE engine failed!\n");
    940 	}
    941 
    942 	return ret;
    943 }

regards,
dan carpenter
