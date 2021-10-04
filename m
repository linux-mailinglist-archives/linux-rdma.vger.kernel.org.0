Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED334217B1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhJDTlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 15:41:40 -0400
Received: from mail-sn1anam02on2078.outbound.protection.outlook.com ([40.107.96.78]:25954
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232043AbhJDTlk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 15:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIBP+gk84LUfF5Du7gWW9Ucq8EbwWIgvNV7/47g71wdzyH9QpMKZapBWR/FkCPHzsazwk6ddfH3AG/UM3dxk36aPDiERHRFJNbqA85LN+UIMnuxvJLE/8sRZRlU+XVetO/e6gxgF/7qtMnyToRMAPSvN2h/OdMqL8Zt8/wAXHlH1Sjoxd85GB2FkHRyKRyATuDVBZ6zbzUGnLe7B2pazL2G+4amUZdnSMDt8uTu3qSef2P6sKBjOqRcmTA9Xd45RuC0E96aqpaX0JNQy/6N7eSvXcGjOVBUoGE7G2oLUxNKoFRzaghpOAwR0lbfNYj2RbVR5ZgZ3lkbmT2b0ELJn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmhECqtXEOJXCofanxSeCvLgfd1GjEuqaQI7E/R3IHY=;
 b=ktBejrz79Rn+zUsXsbMUT08YqVXHJmFmhW0hy5MF7qUlSa1ckuq70/hRAVy2bgkB2A8w5sNfsrztXHnZclxWFvfDl0FIBjbY6vj7R1lqwqWX3FRRcaQlkRJcRKwMQBTidnFXP6Qe9zwzdUeZEhHIKvYXuHgzXun9S2FX9z4/wbSYvWEXpDYtdVvTSEDTzJ6MpH472qFycNRjeaJwU/z+PyOi+YW6fv1bMKV9r5ElSnQQ0y6oeJuElFIyNeftP26AWuUwyzMuo75ySjZoqJZXZdivFsiMB301yOAYIPRrQejlClTd8YVF5kwQzfIe46cFCHQ24x+cum2mWcWV4R8y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmhECqtXEOJXCofanxSeCvLgfd1GjEuqaQI7E/R3IHY=;
 b=DOqEwxnhs9D9R8gk/XxGAWhbd+LFS35qCOkeUa3Bm2XLorJy2sTKso3IVDM2ZzeQJonYOT/u9seBBapBn0V8lahKT+N/Ur8vhKw6VP9bfdhVs8IpkxfNQBGgDJrigGgMKiMY+3jivV+J4LavW5dIXviAlu0LpukksqsUXobnWZGyPYoJDt+Kbi0hZJSPy9wjg4VCsT0ftYmzsO7ad0hwcmXUva/zJkX/QrH7uX3jnzmcTssaizrZI78r4EHy0VYkZdj/D0ylxXF/V798If5aKirpjFsKhUsTTnWrI5JwlnOysayNsXI3yU0GkojAHlqMgLmHLSTKvS20gGCABXzF/A==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 19:39:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:39:49 +0000
Date:   Mon, 4 Oct 2021 16:39:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Split apart the multiple uses of the same list
 heads
Message-ID: <20211004193948.GA2565959@nvidia.com>
References: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
 <67155640-e38d-ed1a-5af9-693f9c860f21@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67155640-e38d-ed1a-5af9-693f9c860f21@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Mon, 4 Oct 2021 19:39:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXToS-00AlwJ-60; Mon, 04 Oct 2021 16:39:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e903737-c30b-41c7-f04f-08d9876eba72
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52210126CD92591C61F767B8C2AE9@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+e/iH9IwqHrgEjueycM00MiCKuMd8MExI9UyOXdwRI4prF2D2AYAh/1B4rkO10fJwKPoijd22w+ELemVkUlPf+Wc0QLlC+zFYMFfSe5RpT8rvB6VphJhr/3naQrgHJXYASMD6WzafLDZ0bbaFmL2SIEs6OYflCSS+7L9gthH/9JTJ84xz00OwpuiVaOYoBLSOp9p5nNoG9Rlm6kvHTpEHfDKS1rf7PYL7mxZArgZUVmlSSAXpJm4y6r+BJJn3yMFe0ekAFh04VKueIW2hh+BKyRu4YjXWJiU2aJt75ifPgNU9w+mSD1GWBmSX7zNvz4MdOrpK7TJjK7oRa8NNK0VAyvFWo9hX0cWyZ8cE0NKQysdC/oUdDv/qTzE+kFUOgmbd8zFVB93N5jMLYMtNeRhYKjmwm2fXvXHKtLs17fcykHl+nQnD3K8L0lF8ar3ZXI7YCizs2V0kYeT8tpkrX4RcFK+cmHzcAFI4MU7zGYWiYDVWHlKzbdm/8Ufz6z10b6qRwjt1RaS6vb7XAL+rF3WTaligZS2BB6CN8q7Bd8T3FzuYsK4C4b2oX3Hnk0Zu9JGYsFXeyxoD4E3Y/pd0RW6v591MSi6L6luHZ0wTV+aHB8OQrkwREv9dn0evO4pB2S+jfCYP+KFYp5tZqtlI5+eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6862004)(38100700002)(5660300002)(8676002)(86362001)(1076003)(316002)(37006003)(4326008)(4744005)(9746002)(9786002)(66476007)(426003)(8936002)(2906002)(36756003)(83380400001)(66556008)(66946007)(186003)(508600001)(33656002)(6636002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpK0+Bn86GrbalwAl/RpZTCqzfQgNXCVApA8ZSSJwvC1r/hw84p62qlRdTSi?=
 =?us-ascii?Q?pzKJRicE6+uj0z0c7BPVz2JnY+bWpfGsT+DSuKe2isMEjxfAqKOpX0uxh/JL?=
 =?us-ascii?Q?k374aBqCoJgRY2NgJbKIWpv6vaSLERPr3w6Ndw38VBpcj//QWn0E8x90a0YZ?=
 =?us-ascii?Q?HFSps/ivGLnYwARIo3KwcYZSPoJDKMezAIiJc1qk7myqYKvNtGAT8oo2esGV?=
 =?us-ascii?Q?VBfZPQyuDOBD164cuH4t4R6cuYikggUC3s5qG6we27CiQnu+TNpjwUw13w70?=
 =?us-ascii?Q?PLWRxDTeuvQw4p/LEUGnPfN4kPFQ7PGgQJyYLpYy8lgMLDo+Ex0DtrRad4y7?=
 =?us-ascii?Q?L1GcVvO9L4m+xHE6i6HLfNie0pKhsZtYj8WlY3rtDodV6ilBtX/51oxJ5lDa?=
 =?us-ascii?Q?8D5VFEyW6PBckBP/1gMop+GRg+BwAdrGX/0ZztxVQWTJ3K2SetYbIb8+YvWj?=
 =?us-ascii?Q?m4wsktL9gV35nYNaWmLgQ9ALm/NMFV3OrA1EMpRVJ+g47WGRlEqmfMPL6+Kh?=
 =?us-ascii?Q?n7wvOL6h+MmZRMAD1sqrxqsLyXYqEDKYGVLlQGsUktyn79+ymvMHMYn2uoRW?=
 =?us-ascii?Q?QpYFQHBa1dKQ3ahJXFO0mZlMRYtu6xzRSM9mlfiPtRDC6o0JX59yChHM1NdQ?=
 =?us-ascii?Q?0a+YnRtHPdFwznvzMqVnF3Q6cLH97r4QJKeILY+PJYDDDiKxbMR+U+0vm93T?=
 =?us-ascii?Q?vDCwa9adfrJcdS2LqWbt5ZVidX8zp1mp5PHSz1Zd12uPk8iI1pvc20nrY41t?=
 =?us-ascii?Q?6VxU10OgaU6ne+EMkiXJ9ah2rxr9rgaMwxH2BASDYbVPRsDsVi/skCNo1ye9?=
 =?us-ascii?Q?qXpDIWZBdtcU/y2riyoLYHRW9x5GWT9uyq7jHKPqvjjcex0Q4c5CNRV7VhoG?=
 =?us-ascii?Q?tpAjvNpM9U9QH2qGwCNEb/zasaa5BDuEgudsCKgu9va2+oio8dmmHUBn3Fex?=
 =?us-ascii?Q?AYdPeetECJjZL2/S4IkpiXBbp0xEdBi2HY9MgpwdRpVpIfwWtc9QgsP6E+5I?=
 =?us-ascii?Q?ibm4RGU1r3fuoyjT3xkVmOAeirx6RNTKEfmO5kcan4q44NvyYekbEHsYy0ZS?=
 =?us-ascii?Q?SwF28A0k4lwCHADf7OpgJBbWXlqvE1IEYcMSAwe5gW+KlBU/CaiD7XjOrD/0?=
 =?us-ascii?Q?4DDxyLsUeRszQk5DsQoGoz5wqy7PUxaDw49+pwOw6mPU92OitOWyQYVv9FuI?=
 =?us-ascii?Q?wMJNQEAzipW3mlxY5XqwIGAlkslq7YPy0jNmOIbm9Z1XQpJSXlvSMHu+TiiJ?=
 =?us-ascii?Q?SchVHSEDrxopiuAVjh/aRCQBULC6VYUX8a/W+77ZvKMb5itcF363ytTnJF+K?=
 =?us-ascii?Q?unzQOM6bM+rm9O2y1X+3LTVs3nt2kM7LQjFmk18/Ml95Gg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e903737-c30b-41c7-f04f-08d9876eba72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:39:49.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEOu2HyNY8tcGvKZgkHMcdFCJ5PzLqtAvdkFleY88nykUfDuyAC9y1yZzHuZsdtY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 01:11:14PM +0800, Mark Zhang wrote:
> > @@ -4928,10 +4930,10 @@ static void cma_process_remove(struct cma_device *cma_dev)
> >          mutex_lock(&lock);
> >          while (!list_empty(&cma_dev->id_list)) {
> >                  struct rdma_id_private *id_priv = list_first_entry(
> > -                       &cma_dev->id_list, struct rdma_id_private, list);
> > +                       &cma_dev->id_list, struct rdma_id_private, device_item);
> > 
> > -               list_del(&id_priv->listen_list);
> > -               list_del_init(&id_priv->list);
> > +               list_del_init(&id_priv->listen_item);
> 
> Should it still be
>     list_del(&id_priv->listen_list);
> as it isn't dev_id_priv?

Actually I misunderstood your question

Yes, it should be listen_item - it makes no sense to delete a
list - that would just randomly remove the first item.

At this point we are iterating over a device list and the rules have
device id_privs using the list_item side of the union. Only IDs on
the listen_any_list use the listen_list side.

Jason 
