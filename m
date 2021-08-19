Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49213F1F7D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhHSSDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 14:03:01 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:28129
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229520AbhHSSDB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 14:03:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JApL7keLCqm2M+FI+jJJXWUePOoVBPk/3Rm0TCSjtPBeVs51jDTGWSafdJaC7gHh6JgrXyrX6zQgbtVphpCj4eOaY/2Pz/c5msNumYPtcQAERfvqbVhfXlhFT7MDCn9RYUOP0G1ozYZGi+OFsM9qrMS1cmyHkWw10+OIk8ZGerKfaC60KojB7Bnrw+wqvvLnsaTSTlXcPxWEVeFEvz7zp622AxwIfUh68s3fpD75CTQli0ZOC/zS/an+e0/L485h5FfeU8xDcvVkIw5KUhhwza5FjZWMPm3Z1RvUIkqEMlcKwK+FzeQU8RrnngFHtWw6z/lNJZBN1nSNdHxFoPFECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3flcImz4lKwbMJr5YY/IaibEP7tZdcjs3c2rSGdUJA=;
 b=kb3Hl1+nDeqhRGZEuf2Kz6BIWRfDzi/C4RstkWQqmMifz0L6qMxCkqQKBuAtJZyznZM1kZzK7J8kHjlVk00Cb/TTWmmgx/oWVvoFnynWyBR9t2gfpYZ4BGdaPRnMP324/+1i2h+3ISbIUj9/yJIFuk1NksC8z3hxkVeaKyOfGzRdFWN++T4cZSSJTLXvM+7nRsL72gP5zhvF9HBp7+2q93dGUHi/CNsKCz9pV6cSJk8pnmiy/zCszhQ8V6AgaLym2iIzp4NrjRmtXhUCtKzh5N0Bu/X+vbebpOOx+Gta0nv/AdM11phVyKPbdMfQkSuJf59+EOjKmgTUnPq4efw40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3flcImz4lKwbMJr5YY/IaibEP7tZdcjs3c2rSGdUJA=;
 b=LDdaZvnPYYfvSVz6kA3k9UdPGd7VlZ60/fBYXP/64VRUQDIQlEVQ66ujVBvqAfuinVBVNR+4en1VWhyHB7ipzwTFxY6srPt6+EkrQSNce/9YrapXitt1dBy8kk1+UlSWdK7R/Delb9mAuEc8k9YDtD2gPChhiJn4IZU1/v8WEyLtbuZyCWm6sx5o49D1wI34SxPr9gTrCvZ+yDJbcsfNPOTqwc5db4BZ0OvS5YmBnESlS3PTwn1rb92e1FxPEzfLfOGg8AUXPpwuKJlr85bD36A4PHAS5RN219YrRWZBH2Owu2qO8AhH2bL9PHTAr/owEeMGzUEJJrE+p3o7moKaZQ==
Authentication-Results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:02:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 18:02:22 +0000
Date:   Thu, 19 Aug 2021 15:02:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Remove redundant unlock in bnxt_re_dev_init
Message-ID: <20210819180220.GA366515@nvidia.com>
References: <20210816085531.12167-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816085531.12167-1-dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:02:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGmMu-001XMD-C7; Thu, 19 Aug 2021 15:02:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22081f11-b3f1-4992-d850-08d9633b7e4a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141F98A1EB86B65814F9BA2C2C09@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38WlVzO2I5dgQsoaOZbUAaV+wfnroE8w3c1xm4jpUcdLQn11JMiqoyUqh3Dy1HYE6c99epEatkyaJi9I/CKb/oBw0Y4R08mzGeQTKSfGHX8B6RlrgxjLM9IQBPX5L9SIvz1SGFOG2UNh25OyqiwFnDrZVO8DWMK6iPOmHKuNbyQr8Bb4ObfhBItAlDnLN6EKdiYZsbB22DuJKXRiFrTrt4EUQlCGRyXc5ZgthmEbX+TqWAby671djdgXkHVuSiLTfh7Ga5yUoa4wfZ+noDkF9OGQ1tmfQollqHn967bX0KaCZ304z9jscD/7rzdd6btuy9C4S8D1hJgVSuv0FizlIk/JmMd8c++sWN1Jidz4wMoNFJwtw/SMrVso1dN8t6GkQV/nZAjWMKQaDHl7Gm6raqXRO2NdVWvSmu+zvbTIbg85BV2cO9/p5/+lwTbbcT+pHmvnfNSHmMJUBKmZFhjBPI5OzojFltxht9lO+X9lrg/a29gg2/9s7jJ6YT5GlqYI5EaxEo1Enz+2W8BJLrB+Oy6S57BdwXGgRtUfBFqRWFx3rvUd9eD15U81vR5QuOvy3V1NnRGN0NdE0NtxhbT0I9xNDdv4u3gMrB7Fs/eLpTLsQ4vr7l31PCegeZagtpryyjjZTKJ0XtUTXrUeN+dhthR0+Jr0NEp3rCcU4UPUMvugqC0EzIJr7vJMJ/HKst71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(83380400001)(6916009)(54906003)(2906002)(4744005)(426003)(86362001)(9786002)(66946007)(5660300002)(26005)(508600001)(66476007)(9746002)(66556008)(8936002)(2616005)(1076003)(33656002)(38100700002)(316002)(4326008)(8676002)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K52ZBmyRCIiIRdZCYWeWE3ltvipnsQx4PKscBGGkJ0BYQ4uePBfw+auxqNR1?=
 =?us-ascii?Q?6xZ0FWNIVqd3zeloMwcrYZSLp8tzA8F+OuZlcik3skyUYn96qwvh/BFxSPbR?=
 =?us-ascii?Q?E7RMh2kT8UCihyBYrhegOJhybUqhAbQOZ9pbEJDhh2Nwirw+k26pydsLnI4L?=
 =?us-ascii?Q?ZijvGyVBEuwzuiiTayqhiWSinXtFy0pl0aWZCeWV3hjcforXIHVyIOr/w6Yu?=
 =?us-ascii?Q?rZCRMUvtFrD36sxOVziASBcmOanijJmITZwQCU+86uWEW27Ifn2r6Z33iVnS?=
 =?us-ascii?Q?HX7tarZ/MKGQdp6sm/O7D0ow55vLUC3Xv2MDuGAx0D8CyOAoZIxeOf5ExeXW?=
 =?us-ascii?Q?QkESLPmgbc7aw5AGFPOAUxY+hiKIb7lmwFWdNoVA6obsXDqpRKKS+GV6k+TL?=
 =?us-ascii?Q?w17ddyCHBKiC28AsM+w82TnLyQxuqlrkmVZ02JbpTwJ+IOtwsQOD3HsnsDgr?=
 =?us-ascii?Q?ua46wlM6cuX9JcLds/b/tiokQG46oRxkkIt47WBxGdpZNXfpiLuRW4trTqR1?=
 =?us-ascii?Q?gXfeLxwBHEEhm+2BrMXLwJNihfrR8xlh/zry22LATBFbApUVZ4Ngb/gbozjV?=
 =?us-ascii?Q?oKp2/XlGbqMitRGOi5DioMbXODs5NAsyX0BEBHD+WNwITVETRtMpf7v04Yeb?=
 =?us-ascii?Q?aQoRfZWkd5XhseJQP4XSzRZL3z+XuqkHqOslXugEV/txd7RvpQ3li511sknf?=
 =?us-ascii?Q?bkTtx2C6PZXdkKPriQWnj8ZVsbFj+HoH19K6SISY9uFmDG5v4+h+QbMBmnaX?=
 =?us-ascii?Q?uLVDSOQDw8wUIBQ5Xonqz5S18kIvrYYY6JZ7ETZ4450n17MdJRikwaI5dI13?=
 =?us-ascii?Q?k6BhTybxB0+Q/7Ydbd/SkBM/trJLFM0qWydGja//BLIqRKPWFmlzU+D7ZJPY?=
 =?us-ascii?Q?nr5k8+S7qISfVBJXowQpjF74gcPo+JUWpglLL/qADeBpNbm+dtvkhDkcjASe?=
 =?us-ascii?Q?Wy7gfW2ZdRRTX2LhRbbv79AC4FfTsNAB/Z/1oVaLlVLtrPzj00KowAj1lkgM?=
 =?us-ascii?Q?M820UBvkHHhfqspo+LNs6YVcEfQLxujEdu0FOCQGjr8JJtur61pwxvOvhGsR?=
 =?us-ascii?Q?wnMcZK12n35Ckn9Dn1QA+NDdhOZ+A0g0GHyTAj0JKKXm/pU7f9URaBNV9ZHl?=
 =?us-ascii?Q?NWZgd+jQVGOkUiV/0YarlO/kFPR0sj8CU1cxNThyncjibk9qdtlhN5rpa+Vk?=
 =?us-ascii?Q?hgCjkoYA7WfhZzsOrPZsgCfBYaYEiipEHJsNQKysS2FZpuLxIrVVM+NSOtI4?=
 =?us-ascii?Q?Bkvja6TYNn4ZneE4CmWbvPVveLMnaaDK7fpwB+Ob5P5E2e0SKlcm5yVx00K6?=
 =?us-ascii?Q?mAuOlcyG3KjFlWCEgCofNVjQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22081f11-b3f1-4992-d850-08d9633b7e4a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:02:22.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HeD11jDV5OzmpooIq2TvkhzjucQg+UwVzjDOX8ArpXmxAK1TlKFhTlEAQZfvuux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 16, 2021 at 04:55:31PM +0800, Dinghao Liu wrote:
> Commit c2b777a95923 removes all rtnl_lock() and rtnl_unlock()
> in function bnxt_re_dev_init(), but forgets to remove a rtnl_unlock()
> in the error handling path of bnxt_re_register_netdev(), which may
> cause a deadlock. This bug is suggested by a static analysis tool,
> please advise.
> 
> Fixes: c2b777a95923 ("RDMA/bnxt_re: Refactor device add/remove functionalities")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-rc, thanks

Jason
