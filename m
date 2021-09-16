Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055EF40D2CE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 07:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhIPFMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 01:12:42 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:44895
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230193AbhIPFMl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 01:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgOcWmI3aNrQZtUuooQBHHlN8UVOuMl4eVdVE6dvfGs4Alx7mlSPzAy3yl0dJVH/bxaMguFs8qq5qE/pLYTGLt/fndFK0l2CfoLZBcMCvXNekIdzEl2iTEO5NiKwIoaYxJI+C9br6GEN5dmDc1UmkPKHbRaw7UmwgpgbfgWe0W7XtZqUsihgcb/HSu9JNhUOM+GGhwIc6uoLtClgjItCylaARQMy1QvEYOXpbpbeOPlxX94RLoPCdKHHkJo1pwnClneZGCjmSEUQczc83UIlX2tVcQo0P/6J/MZavdKhERyE0CmgQgsYdKtR/xhRNN6gpZnbbm/aLLhG0T+g1Tvjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qXkWhQWPdtAlsOiqpnlWDgxo+vSNp1mhm1ZqDwg0ApM=;
 b=YLv4aqpYWejXBk5MmKFTe9V32/WaHV8LJXegmPbhUbTqnbHW1jS6lr3FTlC33Qt+n895pcmEuaTdVJg5jylqiKe4Yfs9DYKCuDPRCJvj2LdOaDYhjzux8brEF/9i6b3cyscdwvBUXbG1lsVnJU1BniVtDZW3NTMl8Hl/7LdAsgD4FWn0QchytV0YJbVOF61t5IYVuHfBVTE3Xdezk7vGZa4gnjkWLN0kHvHrR/445PZb/nbXCnn1oyUM9ZMWFLnpyX2Nesa2m3pCye929dgrjiryeaqzcpLYRFlMXg9dfKUrWjdrnDepcNFluRNH57vRmvm18ZXEjZUTX9O2jQJx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXkWhQWPdtAlsOiqpnlWDgxo+vSNp1mhm1ZqDwg0ApM=;
 b=pOY1Sz/3XHgFKYFHfpbvP9OWO9GhPFBnyA0jXeAO61aXY9Nkwq259G3cW++GkG6ddiTogzFfQuu7C+R0Q0rL1/SHo5xV/sR/ccZN3+WtiBB914JVWCSTyeD+kkgmVyVM4q3KOW7xjkQKwfRL1cb+Aiw5TkBnw/2Utp2ZrjF+Iw+p3kA/UTENj1M0d0ce4hEkb+6dkFBYgbkXVYqfTguwou6MUysaU47Yhno8njP2KdPiS0876hQVr6S/7gFgnOzvi2uDKqKxP/l47lpm8JULfjOb0xJ9MnPuqgRizT+KdDQMq9r3LL3MvoYmsIauR/iUQVelkBCKeIM3WUi42YVTmg==
Received: from DM5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:3:d4::13) by
 CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 05:11:19 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::e8) by DM5PR05CA0003.outlook.office365.com
 (2603:10b6:3:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend
 Transport; Thu, 16 Sep 2021 05:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 05:11:19 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 05:11:18 +0000
Received: from [172.27.4.155] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 05:11:17 +0000
Subject: Re: [PATCH] RDMA/cma: Split apart the multiple uses of the same list
 heads
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <67155640-e38d-ed1a-5af9-693f9c860f21@nvidia.com>
Date:   Thu, 16 Sep 2021 13:11:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f23cdd2-6bbe-497f-264b-08d978d06af4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB251967D992C03846A9787F0EC7DC9@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UW7tOKTLwNCS2ZOwWeIukr48rqvPJLpAlnEEfAG3ckfUbb3qhUbSX248dpIgbAVQkq3FNIyHW6In+DB6j+etzQappUbbLSRBGp9ztZLHExBdqOGRHCBLLrrNmcXkJEOeuVmjVy6L+9zYk9VhHSuat9qiUZASsw79JMbdoLjaREjOj3krNk43znK5HXLYH1tIV5ywDA72Vx6VTbSzRpwJhGehX+HLnc0MoSzKytJ9tRG+7i5x6C7MZdzJtz0dmawTXi9u2f75KKW7e/19bVdSt1zpnxl/YhXq+EXMsJl0yG7u/d98nrO1SvNU+BRMH9n6kBkgU845e7lBpxAyJo55T/k222qVOlciZUwp6788Y6HeHSjaigdQvZkWgLXvBXeNsOqfjMvy/XI29HaKhchM/k9chQynrOWNpJA9hSRgyir0cFtSvHBF669t/CSh2nsPa+xsFUnnHOyNu/FsuAmRC2Ax+OScmGvJhEgmwpkN6M+ro0017J8h9bQE2fAJapBh1/pbZPGMbD2xSM235CspTBBbqe6lElBxT2J994tCK0LiHQfj6YUn+LKBCfERxAUM/mCLLUR4CMwsfhUnlF9Wo5mOd03rcCGU1VA6Gvb38/Zv75bm0t0ndQZnn77Grnlq6GWb1846sjWwmgim0cKYufXTiNV9rZ/2hMNeG86JAG/+QFNw/yiP37MwESva6G97TePQSXDfVC07A/ua29ylm7Y1/PqNiPYDbVl97EguSmM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(31686004)(186003)(8676002)(110136005)(70206006)(53546011)(26005)(36860700001)(5660300002)(36756003)(478600001)(83380400001)(6666004)(316002)(2906002)(82310400003)(36906005)(31696002)(426003)(2616005)(8936002)(16526019)(16576012)(336012)(47076005)(86362001)(7636003)(356005)(82740400003)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 05:11:19.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f23cdd2-6bbe-497f-264b-08d978d06af4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/2021 12:25 AM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> Two list heads in the rdma_id_private are being used for multiple
> purposes, to save a few bytes of memory. Give the different purposes
> different names and union the memory that is clearly exclusive.
> 
> list splits into device_item and listen_any_item. device_item is threaded
> onto the cma_device's list and listen_any goes onto the
> listen_any_list. IDs doing any listen cannot have devices.
> 
> listen_list splits into listen_item and listen_list. listen_list is on the
> parent listen any rdma_id_private and listen_item is on child listen that
> is bound to a specific cma_dev.
> 
> Which name should be used in which case depends on the state and other
> factors of the rdma_id_private. Remap all the confusing references to make
> sense with the new names, so at least there is some hope of matching the
> necessary preconditions with each access.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/core/cma.c      | 34 ++++++++++++++++--------------
>   drivers/infiniband/core/cma_priv.h | 11 ++++++++--
>   2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 5aa58897965df4..f671771a474288 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -453,7 +453,7 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
>          id_priv->id.device = cma_dev->device;
>          id_priv->id.route.addr.dev_addr.transport =
>                  rdma_node_get_transport(cma_dev->device->node_type);
> -       list_add_tail(&id_priv->list, &cma_dev->id_list);
> +       list_add_tail(&id_priv->device_item, &cma_dev->id_list);
> 
>          trace_cm_id_attach(id_priv, cma_dev->device);
>   }
> @@ -470,7 +470,7 @@ static void cma_attach_to_dev(struct rdma_id_private *id_priv,
>   static void cma_release_dev(struct rdma_id_private *id_priv)
>   {
>          mutex_lock(&lock);
> -       list_del(&id_priv->list);
> +       list_del_init(&id_priv->device_item);
>          cma_dev_put(id_priv->cma_dev);
>          id_priv->cma_dev = NULL;
>          id_priv->id.device = NULL;
> @@ -854,6 +854,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
>          init_completion(&id_priv->comp);
>          refcount_set(&id_priv->refcount, 1);
>          mutex_init(&id_priv->handler_mutex);
> +       INIT_LIST_HEAD(&id_priv->device_item);
>          INIT_LIST_HEAD(&id_priv->listen_list);
>          INIT_LIST_HEAD(&id_priv->mc_list);
>          get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
> @@ -1647,7 +1648,7 @@ static struct rdma_id_private *cma_find_listener(
>                                  return id_priv;
>                          list_for_each_entry(id_priv_dev,
>                                              &id_priv->listen_list,
> -                                           listen_list) {
> +                                           listen_item) {
>                                  if (id_priv_dev->id.device == cm_id->device &&
>                                      cma_match_net_dev(&id_priv_dev->id,
>                                                        net_dev, req))
> @@ -1756,14 +1757,15 @@ static void _cma_cancel_listens(struct rdma_id_private *id_priv)
>           * Remove from listen_any_list to prevent added devices from spawning
>           * additional listen requests.
>           */
> -       list_del(&id_priv->list);
> +       list_del_init(&id_priv->listen_any_item);
> 
>          while (!list_empty(&id_priv->listen_list)) {
> -               dev_id_priv = list_entry(id_priv->listen_list.next,
> -                                        struct rdma_id_private, listen_list);
> +               dev_id_priv =
> +                       list_first_entry(&id_priv->listen_list,
> +                                        struct rdma_id_private, listen_item);
>                  /* sync with device removal to avoid duplicate destruction */
> -               list_del_init(&dev_id_priv->list);
> -               list_del(&dev_id_priv->listen_list);
> +               list_del_init(&dev_id_priv->device_item);
> +               list_del_init(&dev_id_priv->listen_item);
>                  mutex_unlock(&lock);
> 
>                  rdma_destroy_id(&dev_id_priv->id);
> @@ -2556,7 +2558,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
>          ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
>          if (ret)
>                  goto err_listen;
> -       list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
> +       list_add_tail(&dev_id_priv->listen_item, &id_priv->listen_list);
>          return 0;
>   err_listen:
>          /* Caller must destroy this after releasing lock */
> @@ -2572,13 +2574,13 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
>          int ret;
> 
>          mutex_lock(&lock);
> -       list_add_tail(&id_priv->list, &listen_any_list);
> +       list_add_tail(&id_priv->listen_any_item, &listen_any_list);
>          list_for_each_entry(cma_dev, &dev_list, list) {
>                  ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
>                  if (ret) {
>                          /* Prevent racing with cma_process_remove() */
>                          if (to_destroy)
> -                               list_del_init(&to_destroy->list);
> +                               list_del_init(&to_destroy->device_item);
>                          goto err_listen;
>                  }
>          }
> @@ -4868,7 +4870,7 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
> 
>          mutex_lock(&lock);
>          list_for_each_entry(cma_dev, &dev_list, list)
> -               list_for_each_entry(id_priv, &cma_dev->id_list, list) {
> +               list_for_each_entry(id_priv, &cma_dev->id_list, device_item) {
>                          ret = cma_netdev_change(ndev, id_priv);
>                          if (ret)
>                                  goto out;
> @@ -4928,10 +4930,10 @@ static void cma_process_remove(struct cma_device *cma_dev)
>          mutex_lock(&lock);
>          while (!list_empty(&cma_dev->id_list)) {
>                  struct rdma_id_private *id_priv = list_first_entry(
> -                       &cma_dev->id_list, struct rdma_id_private, list);
> +                       &cma_dev->id_list, struct rdma_id_private, device_item);
> 
> -               list_del(&id_priv->listen_list);
> -               list_del_init(&id_priv->list);
> +               list_del_init(&id_priv->listen_item);

Should it still be
     list_del(&id_priv->listen_list);
as it isn't dev_id_priv?

