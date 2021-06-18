Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9433ACBFB
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFRNVn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 09:21:43 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:39297
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230438AbhFRNVn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 09:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFnk/xNVn/mqGqAjA8FAwKljZ0pG7FuAF0L+kEH1cFepAQvHNAfEkzCxZdeyFzJF8pi9btfNpIxRCH+unqhoFSJNBVB794B0UZwIdwHG7YgxEVL94IUd28C3dpPQkyPf+b7Feuov9XYYoTltl9H1ubeXlR6ITYMTePWkrY0u8nbXnlEm9W1rG46scXduwsaT3wqpr3wuGBGOJw9CZqyuki7osFruFWyWDq5TuzKFciNlIH1LLlrcSaPfircxZnmKHmC2O9x8/yataF3KLiV4rJqrJkRrKvovHDSWCaQPcGQIrtQwOG5/n/20UseczWZxd+ZSv5hKMs2pgT3vFjDnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkapWTNZmuyYZpD7PrDJj5OZIo19dfu9pMUNSapziZ0=;
 b=Il9pCZHAuMm75aTTJl0RlRyYIrJ+Cvsws8gMZpSnOsZQ3e7ONQA1SaTV5NssMjyYyaRFrYkMZUEDEyyfxsPfAx9AwajH/A++N+odxnrW7avLtw0fsfL3kyU3Et1x3qtgPxNFivHwRAnpCsSElgC96aIgbxogwtPB0L6q6cApVl1Pmrbj8jcJnuDRcrNfqIN5rujYCS3T8+QU6nCY2LEWc4fUEQTkBe1jk8CRI7wZf/FHwoBHExTHJN3N8NrqDgz7+nOya3ByLJJGVGvpE1zoGNKaPndTFUCPZlZVhE3C4gDLdHzxcPO9pJT0p6z5pPZOEE/BCszXLnHitoRpyQW+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkapWTNZmuyYZpD7PrDJj5OZIo19dfu9pMUNSapziZ0=;
 b=J3i2YpWmiblA/e2GG8/7HOJ+YZKDghnIvw8HjbRrwBfHXfSvmn3xqr9uYLAYVkib5E6uOV8+jm6mKtoIWviJFP9a2lvhgRubpKObUr8nr6CT9qP2/zH6qlelMU9fn0vsgee2cuaHDExHIEK2Jid230q0w3wZVDwJWF9d/tfwc9NKg44+OdjMKR5mNY+DN+jl6SrR5DeBlensFgZZUtyj+wrAKaSZplwOzM4+uvpyGej9eRIuzhwgN7vIWtAlVbPy7X/tZL/5Ga+OS/BddE45yvwyZWjkodu1S4LN1qbh7g87ZSxzHgxu/TizkqyNvrGL5NADDi0UMqt+GWiun+VhRw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 13:19:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 13:19:33 +0000
Date:   Fri, 18 Jun 2021 10:19:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v9 00/10] RDMA/rxe: Implement memory windows
Message-ID: <20210618131927.GA1898298@nvidia.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 13:19:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luEP9-008WwN-TH; Fri, 18 Jun 2021 10:19:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452b4818-6a87-46ac-3f66-08d9325bb5f8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5287CE25288BA6F2066F8C84C20D9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjQYDzo3MAwffWhx0U6eS3flG1ujL9f3eI/DydN2R33hJg55BOxeI8GQqVOiEMAHMjxriOA9dwvri6pbW2zSBDY1NciTLHcWlju1tRK+ca3zxSMj78wUAEQ3mptS3cN0sprNQCHSwgNQXomiYCmqsyjnps10vpdhvurAeYC2WTCnX+RHrd3ZdIUW8Yz70Hls366X1Mz5orVtlGR5oylUoy2CEOlraH5tT0tc+dn+QoUWk9/rM8gTm4EgnFD3A26sKTp8NhKoU8rQS68zdSH4ErpySYGp/0QFGyrJv3BjbJmwOZdRyhOU43J4roI2SwRCCSX1oeoJSgJ77t/sI6QJ8TqZAL317yHx789FwoQHMYswAHzD4cVT+8kldXX+XPV+1U/c45kajEcVdZEprqx0dDz6trCLFHAgs5GNwXO8mv6LZXC0P4gIR50cRfbZ/JHRvxbOrO4ylpCGuP0cEYfFXPfRvDwMXMLAsFUkpMFmVPa8YmpS+9PLcf0lL56lzOVUyLkob3UfH8CaEDIBKWQk6UgnzpDSA6qZYiN//CO7/kLlo7xMvAbFdBcwOp0HVh1X/EPgo6ZDreOWhdqO+3MXbiXNPHb8RJU7uPzYwhRD8l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(9746002)(9786002)(38100700002)(26005)(426003)(8936002)(2906002)(5660300002)(4326008)(66946007)(66476007)(8676002)(478600001)(186003)(2616005)(83380400001)(86362001)(4744005)(33656002)(1076003)(36756003)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFBM9B8lL6mZGoIGRy7hd/4jQ8DzX2cpf01dGfYjjIy4wnpP66szTisfnms1?=
 =?us-ascii?Q?WuHSVZLeO/OIFbEqZ5HFh8N8pIPJixJAsIUEpanjiDCc2GTxmmBK3KAJnMZ0?=
 =?us-ascii?Q?EyOs5Uu0r6I7Oi0sTtYDc/SXhVGjBj0WWDU9RH2ihc9KdgRPh0DqmOdP3hYZ?=
 =?us-ascii?Q?KsiyQ2ikBfj158xisfLwCbrg/X+z09v8afpSOWoJr93piACXklC8vL8fLInq?=
 =?us-ascii?Q?sQv/3+9aEMQVoq/PbthzeB6MXnadaE9PXquay9z30AssvMs5uCN8QWAvH6Yy?=
 =?us-ascii?Q?xM8TcqhOndVdPwXzYgy3XjT9pWY3gfzkDC9D7p5l29nRqqpVcbvzKCx7G7eO?=
 =?us-ascii?Q?vMnNNhsRmo/mjukVED8KwXPbOki4uPdqxIwFeD/62dIcGrBsHK/5eXF5PHef?=
 =?us-ascii?Q?IAEgO62xpLBoi7izIp/WgQHlyZDMKvrPaVrrZM1nXAqmE5lvnhJf5yrO0NgF?=
 =?us-ascii?Q?ncROsjJJE+YXeVtn4RGqYeIrKCZycRPa8LIRh0yfamW3LT3Y56lFwM0nm7B1?=
 =?us-ascii?Q?p6dde0IKDhm/LpPvoG0e/cdQoxMFUmK2cBmKzAU+G0bdVpwFk+dDXgyaYpJX?=
 =?us-ascii?Q?BpABAOkSacSHHZncDD83TAGETW5pyXdxBuj56ZF2tDxXsxiCDILnPUqP24Qc?=
 =?us-ascii?Q?Z4Cyq4vtHCykresFvbkT8/FbQP3ziKW6IuZMoyxXsHRQnNt7zgdD6GHOZ0Xm?=
 =?us-ascii?Q?vm5H3r+K2vyRCFXQSCd7+RWx58mIKZZo3xO7qxFSdOFqHnXZAPwHsPylOH4k?=
 =?us-ascii?Q?46cHH/bUzOcepHyMLRCsmvJAI7kCVi/vmFLF8MCdzOHBh5xSFblFxUYZKwBM?=
 =?us-ascii?Q?yLloGl0QEzusFrz5aD3fBCPGsDoaNTaLw9/WDLP1h+mNSflJj/+97yPw11MZ?=
 =?us-ascii?Q?LU+Y/jqAvWXuza0vYZiyfR7Rqb9TmeEtWZwdKqCeRI8ie2Kw3LPWpjgf1FZf?=
 =?us-ascii?Q?J64LKg9vlXYnU4OORP1RDR8GNt9W7zmSpSvvDK4iAYSZ5M2iSQjS5NfoeYhc?=
 =?us-ascii?Q?YPVMQ7RYOUb2RMHVjgYZCFp2PLvmsQCTAoxpmnQAVMmse1KYIOjWRwQMX0Lm?=
 =?us-ascii?Q?rfRx4L1peXYC1mnbOkRRCZ57DXKcBbkoBVOEsmgaW+Fs6gW/Pr9ldi3+jYtC?=
 =?us-ascii?Q?GzGFxGqNw7TVvpfuWXMzCPy6rnEegFkddPQQqJ8iG/fqx6x5nq0K/4Naz/48?=
 =?us-ascii?Q?kCZd9cN3XJ886B/noAHkXTghXPkKNfl8GRLxWrmUJQJlAOZxCuxvCRcfLmhJ?=
 =?us-ascii?Q?qx4Xxj0rPAofBrHDp4pVQJuSc+oUHOk6QLnzYSpauy+VCWea9IDMBISn9/cS?=
 =?us-ascii?Q?dQ3Hl6DafTIw5NKYLoDHBS4Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452b4818-6a87-46ac-3f66-08d9325bb5f8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 13:19:32.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbQNeC1PvFiZmnkVSopLOpYutAcpGzDz4j1h/mfj3lUQ9AvH+rBG7h7MfUiMo8mE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 11:25:43PM -0500, Bob Pearson wrote:
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch set.
> They apply to and depend on the current for-next linux rdma tree.

> Bob Pearson (10):
>   RDMA/rxe: Add bind MW fields to rxe_send_wr
>   RDMA/rxe: Return errors for add index and key
>   RDMA/rxe: Enable MW object pool
>   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>   RDMA/rxe: Move local ops to subroutine
>   RDMA/rxe: Add support for bind MW work requests
>   RDMA/rxe: Implement invalidate MW operations
>   RDMA/rxe: Implement memory access through MWs
>   RDMA/rxe: Disallow MR dereg and invalidate when bound

Applied to for-next, thanks

Jason
