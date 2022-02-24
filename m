Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71BA4C2840
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiBXJir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 04:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiBXJiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 04:38:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704F276D61
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 01:38:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O7iKkA006498;
        Thu, 24 Feb 2022 09:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=bbldkZ7k93fssPENSaqqrZ/4bNvSLpLQYM2ABixhJlc=;
 b=DxfbpL1LVAOdPL1/O44b6nFI3GhvZ/jbkj5W4YUT+23QVvj55x1yTYjYHMFjnhEgJ29t
 HGuoB7Jb/VwR+iqmFLplxinsk/VKJJWZt/XnzckMf5mmEyE+PRjxOV872/125qHrTgob
 /cNiKQTMY4QcHWoObC2Ke3/L/pfaJm3zFyC3DDdRMH3ZU8Codd9p8/gmikeJrxgZYoq1
 yxJSEa9d6tMisMcQjG6T1M8hmYRkbJTQ6yPBr+gaXfjmyetGpmbrCMO3l//KL+JZB8eJ
 LTCIz9XocKxFizFmJOPUf9wgBvu1a8OrTFkk0Xc9Fbe2QliaPXtu7dLgcSN4m2AkLJqv 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6expjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 09:38:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O9anoO128334;
        Thu, 24 Feb 2022 09:38:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3eb483bqp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 09:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpjh7TPkEk1cPIOmhoQLaTJhZxHM2LVbGScKT4l+iKzvI8KRiWJwpb+RMoyDi61Vd+s4J96HkV582xjaW9Zm/0S0r+28PcT+pK3uSSa2VBtKtD42I7q3fx3YokpEkgncjsqe8+qnfLrWJ1nCAv1cmclpKmM13DMh0h07XG5O0cKdlEVYQScEpN1HXMWojWiy1fVAUwAWsp0UJOMluzfvn96YDeJ6ZE8hocAje/XM9H7F9PvVstzCttAiqX0enN7Dy8FLoRcWZpFZ9v2gKT/bwPokYTktLUpxm4qb+1tx1zE+yIglesXf0j6djNim8zLM5PhTthhUAJOCKiW62yKEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbldkZ7k93fssPENSaqqrZ/4bNvSLpLQYM2ABixhJlc=;
 b=mEaJI911qB/cPv/Aa7I+mRpXV0leES8kLQC5B8Mv44vtEf9jHis8sjprASagJZ/sd9K9Lxuvl/oom4MIWLlJi3MM5CAGKwmkzsToF8IwUf/eq6uW6goMrSdcw0utApOkoUCET6icUjiMVtlrEujbivOxBtxsWFFvLRcIiyFgRuGro8tFYGFe8YzfqPkQTeZqRF+JMwixU7zWkqEwg3Ip4UE0i+bg7K4IYweMji9PSt0XxoueBJsPT/qqLMz7sIDv5b2OBXhllqkNSgRLXPbRv1BhovRpCLcrb7BpaKIYVbUeiK9E0VdIqYiUUU9DM139gjfnY25fTqWH8Ih+zujyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbldkZ7k93fssPENSaqqrZ/4bNvSLpLQYM2ABixhJlc=;
 b=bJdwuujMESV8mnIxc0nJHshGcGOoqy45erBJxD5gp/oWui1P8IlXCyzZeZ9GRU3kKx2KmoZvi8PArAfbALG+CFOFo2g4n+uVzy2lRNoReXLGQ7SVP0WJATsd5v8eiPZcfp3l4QtjrrsWBxr6Dj2nSfhA7WBk3bYMzXdcU35FGb8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4330.namprd10.prod.outlook.com
 (2603:10b6:5:21f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Thu, 24 Feb
 2022 09:38:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 09:38:10 +0000
Date:   Thu, 24 Feb 2022 12:37:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jhubbard@nvidia.com, Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [bug report] RDMA: Convert put_page() to put_user_page*()
Message-ID: <20220224093758.GA30603@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0150.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a502baf-728d-47a3-3155-08d9f7795e80
X-MS-TrafficTypeDiagnostic: DM6PR10MB4330:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43304C7D80F5252F87CFFD188E3D9@DM6PR10MB4330.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Jjn8FWv4iY1UV3ss9jFYFif5I5oQJnsANGnk1BaMvnInuvolQuNrHh5tS1uV72KOO74iGPII7CAghjA2sa6IHgb3rPbq/REdKM1yWk/oHe1aQsyU1cO7tifeHmyEjRbaSmHgPf4zbrS+IFa6VjOWLaO+8gTl3p1JQCO8LRMo8nejkj3TJYY70XPSAfBtkbBvMY+JzPUAyQX+soenJbWT/dpHVuEMLQr7Kem3foCj5xw/FSci6qcBUbQWHCSiwDNlZDn4tk495tXMj2zbzmmkvr+m0v9ybBYwIytT7ViNcXPg633hDPi7KBfMa8l6y7XbYZDIY9wZOHGpOg3RFmzZ7+5wjP7Itr2+IZTcIw8AHB65/fSMfDGaOBb6xDY6MCY8GqMvugrSqMvTOR1RQ/qnMnmHCAs829uZL7fSTQrWOFpq7sxpzx6BOXUESFDhdoLgbBfkdgUqObNH1q8QFrpwa/KdMKByu6NLBNju8ISJ4yFZROGymOJNRBZ4HZxh0ISIoLp/WpfVQvPMLWIHmAZiWvg14DZwrykXPwW3EPXbwumeLWzLBk+bJlGgkE1V4X8yZ8ssdNyI6l269Jw7MlwWsh0PON6V3jpMCo0JTyKK9CVULjATBJjk+zuUHQC36S1uAI+eaUVMyReuaINKWJ0q8l8juC1W+gLWs1wkgunnufxztvl9EuVagcPINFhr0av5C3W99XIADwhgSzCtEtZyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(508600001)(52116002)(6666004)(4326008)(8676002)(66946007)(83380400001)(66476007)(66556008)(6506007)(186003)(1076003)(33716001)(6486002)(8936002)(26005)(33656002)(5660300002)(6916009)(38100700002)(38350700002)(86362001)(2906002)(9686003)(44832011)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RsWvClR+dBrqfNrv2w+ODSKdf4ex69Pz5m5K8gOadFyoOLFmBXq/Mk2GBS5S?=
 =?us-ascii?Q?D5bsw6EBY0FRTtsohFWpzHrefylzN9ffhY98KU3q8D4XFQwdrSk3O/+FJPYF?=
 =?us-ascii?Q?g/xjMooJU+3j1TRgf7pS7wCFjokwcElF8MM+xXRnRQi69Q27wFwRKjZzUMs6?=
 =?us-ascii?Q?vyKZ6BjPptcRDHuaeQ6JdqrZ7SAaAPkUlR4S1mgUOf8JnT56udUFC4racmlE?=
 =?us-ascii?Q?neBjeu1U9bogVioukcgTv1MuPAxfUVDVFVtxaz5QwH4kTxh+cMWiD8sKUNNV?=
 =?us-ascii?Q?DjX5B2XPS2qsqXZLxMcutx4HcxRu2+9ebQSyYsTpA0QY0wyk+oNkYnc5pTa+?=
 =?us-ascii?Q?8ma6mUZh97VY9AhveViYQf6Hl45CUTcEuYGs/VEt7sb7hYQL3xeuf7RaYtN/?=
 =?us-ascii?Q?MEeGpL4ASuAE109WcqbTFY+hmlbCjK5C90bG8hfn5Y5qLxO8jzqtN8RRvbCU?=
 =?us-ascii?Q?g3KNfbBFgtD6L2w4AlZBeHf26sRnBaboBFVYgme3bBOgaB+/5Vv6yEwBffz9?=
 =?us-ascii?Q?8YgJ4ozPVpEiOmNgQuqRQVFzItvDlODu1YWltn+FFaF2HexzZcBI7m4QYemj?=
 =?us-ascii?Q?zIuQ2FP9QZcXUXme4nwWAfLDT2zJG18CWfIYpS4bjBmeMn6Nik86mK2/sk+E?=
 =?us-ascii?Q?u3WwaYzrB68GH/OST3WCJ7yRP6K+nzlu+VocwZ7HBilACxo9YLoyvr8rJinQ?=
 =?us-ascii?Q?TGGhFM2hEF+iH8yeeu9lUENmB5Y07TDhS/KkRUaSsjSNr3Oh8UbNRFjpaZXB?=
 =?us-ascii?Q?r9QuWUefcHmeYA25upwGhfJuJE+emNWu7okXrsci7NCd98C+vohFNIYzzAaP?=
 =?us-ascii?Q?lJmHr15ZJkjusJ+OcbnUWUTIIUHEdpp/+SgswRSOKoTCulAv1dZl+WlReQlX?=
 =?us-ascii?Q?L2U49Nlmd+C5dGjwk4nPKVyljQh6QGm57LY181GurFXy/SJtIXkDxAab65ft?=
 =?us-ascii?Q?yk7FZZrvlUCgnvaKDRt7aTAVV6j+F55HqMKUGzdyPVonYup3XHV6XEN74KTu?=
 =?us-ascii?Q?kYQcse+G+LF4cxopLKGCnnywuDPHpZDQninaLw98YUN/ResMyK7IJezRuByA?=
 =?us-ascii?Q?w6Rl0PEEdODgUvf38Ttdkf5oy1jm2SSLaeHbLUdkfzBoCvU4oYiXOFh5nHm+?=
 =?us-ascii?Q?SQuw0ZLAG5Fmt7OHpUxTBxRV9oX/XXWrItR2v6gytm1aekXePJqxN6YluyhP?=
 =?us-ascii?Q?jPyw7JIlUz8gJPjvFCg66QZGWuZuUOD6ZK2OpLvbS7GYoQr+23r1fK3XVovt?=
 =?us-ascii?Q?uXvfrSTaGgQYCXfPQ8iz0/n+nQMYA00bNanOG/t78R1cmn0mVcEWz8lYVd+T?=
 =?us-ascii?Q?HlM6ocfVFtCRJEuPuAlitciOdfHV9nBhEgKMT44Xgx4hBbt9xJoLIX3eeo9P?=
 =?us-ascii?Q?v6GoW/YF2r7afnNbLkusvVyx+k7bjueaH+oAb2M2+x4mg/w5Y/3KYs42ewVX?=
 =?us-ascii?Q?zIdUrv3xyW+NlJe0VdVVeJePVEICulnHunHZl8dLT0o+WprN5KtcHCRvoqF7?=
 =?us-ascii?Q?M/LIerpHKItv3+Or9EGRL6YwSYkWG2yiADxUhUV5I8Jx9AAscL8YpbIjYk4p?=
 =?us-ascii?Q?RjCHKh9UJOBOO8sl7ut8fI8lE5rn1ZrwknqkGUqi2jbGwp8TDksHd/qfBoQm?=
 =?us-ascii?Q?pNjJ+ehnp1TMtr52RTAFxTk2o1ctBXxOVjNS7AUeyqedtg9ripTOk+C5kTLR?=
 =?us-ascii?Q?903AeQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a502baf-728d-47a3-3155-08d9f7795e80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 09:38:09.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz2+FglqGFPhHDSv/cXNkotaJbllqmHQtkGfib84xryT5y3q6i24ua2swnhVR26CrOzZ1ZqZ4QoolzB+qKDF3G1J2KheQ2ff033SeuvHraw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=690 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240056
X-Proofpoint-GUID: OlLHkuJf0XTLaBBuuNGGN8EF42ih_lkC
X-Proofpoint-ORIG-GUID: OlLHkuJf0XTLaBBuuNGGN8EF42ih_lkC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi John,

I'm not really sure who to send this bug report to so you got picked
a bit at random...

The patch ea996974589e: "RDMA: Convert put_page() to
put_user_page*()" from May 24, 2019, leads to the following Smatch
static checker warning:

	./include/linux/pagemap.h:897 folio_lock()
	warn: sleeping in atomic context

./include/linux/pagemap.h
    895 static inline void folio_lock(struct folio *folio)
    896 {
--> 897         might_sleep();
    898         if (!folio_trylock(folio))
    899                 __folio_lock(folio);
    900 }

The problem is that unpin_user_pages_dirty_lock() calls folio_lock()
which can sleep.

Here is the raw Smatch preempt output.  As you can see there are
several places which seem to call unpin_user_pages_dirty_lock() with
preempt disabled.

__usnic_uiom_reg_release() <- disables preempt
usnic_uiom_reg_get() <- disables preempt
-> usnic_uiom_put_pages()
rds_tcp_write_space() <- disables preempt
-> rds_send_path_drop_acked()
   -> rds_send_remove_from_sock()
      -> rds_message_put()
         -> rds_message_purge()
            -> rds_rdma_free_op()
rds_message_purge() <duplicate>
-> rds_atomic_free_op()
               -> unpin_user_pages_dirty_lock()
                  -> folio_lock()

Let's pull out the first example:

drivers/infiniband/hw/usnic/usnic_uiom.c
   228                spin_lock(&pd->lock);
   229                usnic_uiom_remove_interval(&pd->root, vpn_start,
   230                                                vpn_last, &rm_intervals);
   231                usnic_uiom_unmap_sorted_intervals(&rm_intervals, pd);
   232
   233                list_for_each_entry_safe(interval, tmp, &rm_intervals, link) {
   234                        if (interval->flags & IOMMU_WRITE)
   235                                writable = 1;
   236                        list_del(&interval->link);
   237                        kfree(interval);
   238                }
   239
   240                usnic_uiom_put_pages(&uiomr->chunk_list, dirty & writable);
                      ^^^^^^^^^^^^^^^^^^^^
We're holding a spin lock, but _put_pages() calls unpin_user_pages_dirty_lock().

   241                spin_unlock(&pd->lock);
   242        }

regards,
dan carpenter
