Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E741A38C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 01:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhI0XFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 19:05:53 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:20321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229911AbhI0XFw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 19:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2/Z46Zpmag+hZ2C7NPRhFEoeGfFjBzSXdrGg4qugcF9vOSrjsTL7JC/4urw+fTgk7E3BOQMYYBDbsXVfteMKinOHN4CUUec8++J269QHewj88+I8hQYQFcsOGwKlqTtarZp2dJGzw2IjqfF/auCEpkoxCTDX7qLi4aDHmUBNcT/jtr3pemBsNvIyHX0ni/MkSMIhwPR/MHTFOxoJysM4KPQtKIxLeWOxbubRm5FJIn+rEDOKEqtF1ZNEqbv0f3M6YwjSE5tABy5wOwcRY3SRS46yQPn9zhjjeCCumBCELpbQJsB3MTDTr89J19iMCq6POtFyCKFkE5rpmBau4mKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SxFvDlQf23UhxFBcI9PHRJ7qTEj9LIITMH4TkK4B+MI=;
 b=gCe+Qn3rnxqrieQsD4+EouliiEHqaaDzdEgQBRcd2UpGPZWdEhwnn2mLWpw7xA+28xRuS+2IFWlmBgYUd8Lqu0Wh3BCb84QfTkhGxs7/iyXCBqUON+WNgaVJ16ZwrTyCgtIUVc7C6yIBXm6y8F/tDooqdjZ78TmhRZlAxfCTa79EAK0dnmtD/BZzAO8E1cn0AgxUe+1Obfr/DCclmLtXjVgUvt6xf8dwuY1g8lg2H6xJ1UuUN18LeShREwwyM3AZzPptnECoxyddDumIoD4lYGbHGAGAC6wpaGIBEFW0YWlfMHWbc7EnzK6MWwc2AQpsQVbGbPXzmwgCjfTTv8LFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxFvDlQf23UhxFBcI9PHRJ7qTEj9LIITMH4TkK4B+MI=;
 b=F6/4bgLQT/BSsnkV48BA/3d3sLSznBEP70zsXNvN+zYkiJpJmrOMJbKr9RnOlfWbpmAdoLWNOVwbj3m4MX6zYJD4eH0g87u40sFuJOwQTv/R0ZgpthyAxFGszB6O0yHGuBirm88qr/ioDEolOwPRa67S9gYKtXl4kVcljEa/jb0WfBX4RWYayyU6uU1M2IVJ0Pi73oxeo9GD1V/Ews/vjRdsBGhwIlOvWTVvfMgTfvPJ65aZrqwn7snKhZ8WR/GX5U0RMCumVOJxS7eP5Vc5FVAAVgCGmxvvjRk5dPQmPFzkT3PqonT36sXXI6+oCJ4hgh4+mf5gZ/TpWvomgVgkeA==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 23:04:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 23:04:12 +0000
Date:   Mon, 27 Sep 2021 20:04:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: CQ notifications
Message-ID: <20210927230411.GA1590967@nvidia.com>
References: <20210913120406.61745-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913120406.61745-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:236::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Mon, 27 Sep 2021 23:04:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUzfP-006fuK-Co; Mon, 27 Sep 2021 20:04:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66253669-c350-44c1-fbcf-08d9820b1f1d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5239:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52393D1C2176407A31337BEEC2A79@BL1PR12MB5239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Afs686gv/XqXQ4YPoka1959U+jXngHZipvRY+H9BQnQck7wOId4mCnJ225rKZGEC4MydrnRF0eOUFmg7B04rmLoENn9pSo4BkKK/tW4sy1QUKCBJmdlpLQDzIsYGFyzDG51SoSFkXiHBGx+lAYQrkE9alFI7ZuSFlsN0XJGZQHPDn/WA0vwOSy9pJAELNKoH0DH+lBTjR+oQzYeeknmlI4kJ5LecdPGv7dw4W1NiOXyFw4kjQRH2L+qSE0ZM7Wfekcvv5ypQntxiKqyC+8aPqC6bf6ZMzRV/tk579MvKi1uytJ3CelhH9XfZ49uHFbQTnV3BgLhIGP4GspGyriMB29bDE75WTQx0Y8IOX9uaC7lyrpGiJ7aUModQfKq/3FapZi9ae2xSiUBCKdOIgm7Z6XXO3xa7gPkMtGO6ZW1/jjqeojSDfDi6D7HtegAX/buKw5AXrsLc/trwkpLx9GBKwZhtlv+dMGeTUnKB3FB98SNaRkORFlzRFhG80aW1l7fDgkcAbcYXqD4SN9kpFoNMdHyp4qSMt2imOFCVdZbXuow5umja5A+b2owAEGp0+qvMqb0kM7b/yOtmjYWSp/Qs16SKqzKnu/glPXEk2uwfE9YMoP+3W+9v0v7PkM57SlO5um5koDz+u5XOgnFjWu0zeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(5660300002)(8676002)(9746002)(9786002)(426003)(8936002)(186003)(508600001)(38100700002)(316002)(33656002)(4744005)(4326008)(54906003)(66946007)(66556008)(66476007)(6916009)(2616005)(36756003)(86362001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VdtWo0dsux/nsed4jAp9NNLIzu7zHFrmKFFr35ASAUyYy1foqrRKyUeRCDtq?=
 =?us-ascii?Q?Q0vvYEN5D+Ol2uk75G9Gox5DwGWA2oEUWasE4C5tMo7//s8MHNpA1/oXY6yw?=
 =?us-ascii?Q?r9yYU3siGJD40ZYtIMePeDHddGo/4SGXGoSoLIEzNshialKAVnr7Osp74YU+?=
 =?us-ascii?Q?0Uwkh+l2mSfBXVemd6r2QPHUgTusDe4dXkD49VRZjFopjGgRRNsOGk7b9wyK?=
 =?us-ascii?Q?h7q66H2WmGMhHVmmhSkniWOjgzz1j14YlZxGT+lXKeILOq95J8fYAvhVLUcO?=
 =?us-ascii?Q?JI6NUjKBfEeXYArWTGl2HOS7RSwIaye1fP1oitDQlB+z4SKGDTBBcUNQLWj6?=
 =?us-ascii?Q?qmz0pmRDGlhE1Dn41jhK4P5ytM7ympsGDc9Q/T7wMIbKSdMyeDoFh1JBOk0D?=
 =?us-ascii?Q?D7v3YtnETwy7xdQkQOfaCn47nwFX94vdpKCmpgd6leobILFxB5BYwKVqdhqk?=
 =?us-ascii?Q?2vA4VJhm0kj5uEIgSJtpFLE4rlYlIu9EdBXQs2AHEQqhaACtqcOPwCDw68EO?=
 =?us-ascii?Q?0hM9yYXlj+EsQXKwrzIstqG8NHEf4Gs/0dUNNgCg91EAgouzHBRFogc++uav?=
 =?us-ascii?Q?1Ub0K8vsh8cj6RUdVdPbwaln9xNgmw+lRMkBmcUI/7VTcnp15SOZTHelhWRo?=
 =?us-ascii?Q?W1JDiELkRIIdhcaON+KUyQWYtQwUkPr8mC6He/Vff8jlE4wOXSS4vUH9NWBY?=
 =?us-ascii?Q?6AHVgWhi5478LPMcGO4Kqd3hYj/7T+2OwXYGWJmujaxOOv0TndiYrAzGGjPg?=
 =?us-ascii?Q?h7wZIurkKmRTk0RDE5BWCHB7TizjgOH+l2ihb6g7hCQHnZx6Fuy7PNcQ+Gl4?=
 =?us-ascii?Q?wHhb5GRLW5d8elOpvAUuSG4luBYjF/pAx/5TfVEKCkXpZGrR5+TF2Ku5Z5SH?=
 =?us-ascii?Q?6EJ/I5bwKGYePGZlqVmqgdC9f6BPZjJV3ohDy7fBNlTIbdPHr86bGEwQQ5us?=
 =?us-ascii?Q?8oHuKTJpIJnD/KzipX4QQQfGDEUNXH3kcHEqyudWduFSXYfLPcWk7zDFOQTe?=
 =?us-ascii?Q?w4HjDejnm23MuYOnXTCj8erzu6BCvY1guAxylED7kUvnVbc3ZJsbzfJ93yPt?=
 =?us-ascii?Q?gvadbIB65+IZI3VQOB3E8niKjuPqp7t/2Fr6OW6RcuIYFa4DYto9WJfBkkh4?=
 =?us-ascii?Q?8yNKxVRAiRh5+elqLP4O5sp5aNegXBWPl7mX/ZBDNlu4aA2J2NZ6JYDqw+fq?=
 =?us-ascii?Q?PcKQYkIaQhufaV4YzutUMDRwd+zbMnclfQumJLaA3z8C0vZfdvFAyWHjarzZ?=
 =?us-ascii?Q?0yR0l4/07LeSmr67SiQMrOJpROovodGQEKCQqmmSZ2+t5KQrJVBvprYXhHKn?=
 =?us-ascii?Q?1yVGzEaJmVn3j/XQ2xSeq1a6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66253669-c350-44c1-fbcf-08d9820b1f1d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 23:04:12.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fqGAYk/OFHqqAvpW38I6XhG601JWFV6v+lDz8ooPc2xaXduOUvC8VrnOPp9nFuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 03:04:04PM +0300, Gal Pressman wrote:

> @@ -993,15 +1002,24 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>  
> -	rdma_user_mmap_entry_remove(cq->mmap_entry);
> +	efa_cq_user_mmap_entries_remove(cq);
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
> +	xa_erase(&dev->cqs_xa, cq->cq_idx);
> +	if (cq->eq)
> +		synchronize_irq(cq->eq->irq.irqn);

Why is this conditional? The whole thing should be conditional,
including putting it in the XA in the first place if that is the
intention

A comment on the xa_load would also be good to explain that it is safe
because this must be a irq and snychronize_irq() manages lifetime

JAson
