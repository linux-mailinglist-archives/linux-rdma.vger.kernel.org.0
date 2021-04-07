Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F835786B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhDGXWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:22:13 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:22720
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhDGXWL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc8lmjAmFhWSf/DvFQTMC4ZIa2UVmRMjc647nZTlrz1Fk/RBEupwpnD2FTDujS9Q0C4DiIkRNyZkRLwhNWFNkduFpARA0XgE+ShFlKpM+E87B8/z5LP/Fo9+UDu3vpD4zlJRrL7ITwlStnUYGoIJaYn6imQXt7FvKfROPAcNj3OXG7+qmtz3louc1gSUyScDMKk7qGtBKC8r9ejT26RQXiXjLqxTA9bMJP8tgM07YfGEKqgiHUcSrK8xWXQ9Tgn6PvQ5ipeovldWURgyL10p5Yky5/SO3JP3F+sFWejCM7SOb8iyLNXU63RlldKbc/Z9YCb/Ggp8irKEdAinqU+s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhjlIXw2z/Dwlt1KzxKa8HCXvgrnGYtYyQ008DYlUKA=;
 b=SM6Ia1O5C9QeX8vddZA50l9CPIio7S21mr+HsJc7K4ZdqtQrCEV7mT/lwPs6T7NjkVFaSKt2/5iipp11QVmsbmSkUxCrF880AKiD5zy//uy8x7gy7g01BrjbhZD38jd8eRSKiDT4NV8bTOhDZSUsb6B+MCIhlK2LgSaSojwkKdQPKlZhxOc/b/ouOuhLtKDR2jXyeO4ksSJDQMf006bEh64lOJfsqHd8swsT+OzcJqlwnfjSg4rzVlXvh0aovEHHeGWJQ8+aaL1nZCpRdB0zJF5jtAq2Bx5Cgka7/IllXo+EjGzQQjBg9WWoZ8p2sSnO8+mcIeuXST8o5kjH6hxdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhjlIXw2z/Dwlt1KzxKa8HCXvgrnGYtYyQ008DYlUKA=;
 b=nkpCBUOzClITsj39LlT+A/Mhk7AWlp2t5N+/A68y2MKIs4wbBszH+bnMuYt06me4eICmW3zq8JshwdDtyEt1/oqte3l+b82tRcSC3npATLQ+xj/+mvODBGaGvTXjlYYb2lJfAIdRYIt115sQSNAcJ7f43JBeSHHli8kIX89KYOR2LexTuYv8E50iccZAAWBlAV+8a+cC6Kes3XF9q/1pfWQLLJzfjAUCDdyUXII+n1fROSuFG5lyFWgyGPAKhUvKv6pmeEsGUGYMGAhsE8yNUMM1/nx1pqvL2e65jAgGDuJlHIze5dUPVUm2c7kxTi2BouO8LT/wy2nA/8kavSDD2Q==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 23:21:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:21:59 +0000
Date:   Wed, 7 Apr 2021 20:21:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 00/10] Fixes for 5.13
Message-ID: <20210407232157.GA578406@nvidia.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0075.namprd13.prod.outlook.com (2603:10b6:208:2b8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 23:21:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHUj-002QU6-NR; Wed, 07 Apr 2021 20:21:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2234dd7-6ff5-4a28-96cb-08d8fa1bf104
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42667485D133B38005FDEFDEC2759@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8tJ4ELMDYObUM7KV8of/F5jihgjPO0WuG6Rjf45KAis03nPW0Lf9NglWr3wxjPkbC1sZnczwY0vn4/I5DKt52z+5bKAdtVYKr5R26/9nd22joJwYgx8azh8bjuhmkJHK6romzVTAXsgg9Hs6KTLImiuk6bu8rbXPR2ingFmpdI/M/zceMLklA1mQEGQUhkPynMvlAbiGy1ezgd41XQ3YXSR8gcivlHbRzsm91OsIEeiyQN9JEph/xijSkr9brC7LAotmgDSfkYqrzbR5h/TivxB3SJEihdKHUzUqejfA4tdx1E2hrhJEpKZoFu2X/nBjKtfZ4bMH0UAUAHqJmRKxW7uds5Q9w/op2AmPIEpUFoXyvgT+mSHZAAw5yUYThpME+UTCTJOPcHficGVBztNjQ+OUxXJJZJ+UZ2fWsL6zl8zVqePY7cfzuGT7OJkWad1eEl1SS2RoL9PEMpbA6PA8hzSYZKIatmXHCDLv/ETYeUXOyXAquRXVzxCgBFhcLPbtCcuAN3tvMZxmTOX0gaptnTBWlZfn/M3BTLbNiOgLr5KfGBi0JazTzeDhnE1Fm1sqY+zn+LBYX1jx1MhGBUSovl6ZEpw2d3fC59RqWAV9PHtHYEaWitwlpASinqIV5YK50JtkJT9xFTXSKcklFdu1M+Xznnq5uiGfm2e7MJLgkWOFTECkuftDiKtVM0IMmvy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(36756003)(66556008)(66946007)(66476007)(6916009)(8936002)(5660300002)(316002)(8676002)(426003)(9746002)(186003)(2616005)(86362001)(38100700001)(33656002)(478600001)(1076003)(26005)(2906002)(9786002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ID/IFF9jX0X5MQnI3irXLke7KlSrwFt07J9g3SMHG/6jpqYVQmznwCEPs3tX?=
 =?us-ascii?Q?MEMDVrrwJOFLfmqqHU2TKNI7Zv5kpjljgVEwf1OEnbVLK+nL3JjcPYcPkwS+?=
 =?us-ascii?Q?cHPpaMErUiaf0lDnzIqAuS4MGt8WueVJ234FN0A3TwqrqZGV0F0sATzui9Fq?=
 =?us-ascii?Q?YpBbqHdg0RkPBYvRhPzQ4rPL0A+UxStFrpKFLTCerprHSnZCIja3O8bcqPE4?=
 =?us-ascii?Q?aFZeADxh2sf7eg5cqv0AVqC+tjF5fvB1RpIaRPea1tMLVTbTnxLFTdHpOk+M?=
 =?us-ascii?Q?RcbBJSsUqCnefqHJ2r5kL1egSBHX+/Czga3heGFms77BSNscvJ8ixxVy2NTg?=
 =?us-ascii?Q?VhKOG2BHDFmYjhbC4xytSLRp43SyrPTcoYBA3vdhy5YniBAyDeWEKC2KQ6eh?=
 =?us-ascii?Q?W5TSzjS8VdYhFN5NTt2oeGEDmfdoGzmOjRf8bZXcj+yOue9paIxiK0iHc4EX?=
 =?us-ascii?Q?a1pfxeT8/mt+TMshafVLVBoXFSuIA+DOnmAFSPHtzW3r6wDWEOdKhPvXPiaR?=
 =?us-ascii?Q?hlEQzEnIWSQ+0if8VCR8Mncs9v5okIleB+g3m9n94Bb8KiU+fM8+1P7DWGuF?=
 =?us-ascii?Q?iJUkx+0AnC6pMLi4DVLxtNn5MEdKcms4b2+hdNGkxZTIWMOshpxSbLS4KHPW?=
 =?us-ascii?Q?3TQiwjVh/HM8tWTugY3x1MwycklaDj7tUIJKKDRpvse/kOkUOG/NWsJldnLD?=
 =?us-ascii?Q?oEy+IxFL6Wj0KH40SgmKXTwC8fhBEmakxoFTYo3t5+Mbrw4nyQEJIf0brL5U?=
 =?us-ascii?Q?X1LAk/yckUbYC4pbsdXhIRYBw/53ew1C+lWg62H8LXfoUUdFo/84Kia607KG?=
 =?us-ascii?Q?ym5VH0kGbTMD2bqaT+fF9SItI+znyu6o8JaQOYirmTbEposzpCIHuWuviJsW?=
 =?us-ascii?Q?ryc1ibO6PkVGFBICowZc0t3s9o/DJc7RgR68CzyLEl828s0a8ivBrNBkxqVt?=
 =?us-ascii?Q?ry4m3PNDxWaicE07K7VZQ5h7zlAJ4as3vXRA6LBJB47T8e9eIs8vMpwyDyRt?=
 =?us-ascii?Q?4SzuJdmRXHXg/ggL+g07J9uhgmuG+G6S9XgKSlIfMvYQ17HtfP3BasnxtP4I?=
 =?us-ascii?Q?fbNxlRZ5GG3WGBTbJlFiiL5S0SpvYw5mNUqvUb3lUVQZDOKl6YnJFwAbm1hQ?=
 =?us-ascii?Q?/NaRZwKyPgHQ1Kg3Hgo1l19hBv4U75aOUBOM9YxMlqgcJV9yi30mZIifO3sD?=
 =?us-ascii?Q?Fnbd8tHWj+jbwgpUHDjx23g5mNiCYgs4QPxl1mh1qNw1XZduF2ggU4HDnmGY?=
 =?us-ascii?Q?6whODyEKJG8xj5v30TH2+Ym1IuYeqYRQx2KGNLAtMlxFSue38lwKdc9iunsO?=
 =?us-ascii?Q?qFETxXxm+cbcORc517L0alEQVelQNVBCkCzVB1J+KiwNSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2234dd7-6ff5-4a28-96cb-08d8fa1bf104
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:21:59.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI8eLU19yIJphPWVYjQFUC2Dx+bjrAdLToHMVTQOZMVLRgCrW8fUq0VeGiJ25ciG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 09:54:06AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> Here are some fixes, clean-up and debugging type patches for-next. There are
> some changs to the way AIP/VNIC netdevs are used and a timeout handler is added
> for rdma_netdev. 
> 
> The MTU patch from Kaike will to add a physical MTU to query_port is also of
> particualr note.
> 
> Kaike Wan (2):
>   rdma: Set physical MTU for query_port function

I left this one for now

>   IB/hfi1: Rework AIP and VNIC dummy netdev usage

And this one didn't apply, it is on top of the -rc xa_destroy patches
that I'm still waiting to know if they are real bugs or not

>   IB/hfi1: Remove unused function
> 
> Mike Marciniszyn (8):
>   IB/hfi1: Add AIP tx traces
>   IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
>   IB/hfi1: Correct oversized ring allocation
>   IB/hfi1: Use napi_schedule_irqoff() for tx napi
>   IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
>   IB/hfi1: Add additional usdma traces
>   IB/hfi1: Use kzalloc() for mmu_rb_handler allocation

Applied these to for-rc, thanks

Jason
