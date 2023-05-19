Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B2709EF1
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjESSPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESSPJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 14:15:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC63110
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 11:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq7jFwlMNKwcLn4AX4aHLGyjr5q5ZvY21ergjferPcEVBbcZcGsVGtp8QbiEJetRkRYObADyGizEgkFELYzTdbvpgVzGTIHIvI7CQhAz94CZq4dxHsYydRId0pMUIWrnmSWUrrofudzghpw56w/8VLJc9c1Dyw7RWw3g6WxWhZ2/kDlKI9FuppA4Jok4N9NiFzx3HiurnJgiYR+jeQQhm3/AkaPgOGvgW32cVmfFVvCVttYvZwTpb2tmcJsSDEhAnMMbSjH7vP+Bj/Q7TXuY+8rpvLXtoA3OycBjaP7KEcg6n0BJAARdK2lBlFdkey1GgYJIMtZSHBwIpriWsRJYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT9j/pnmlnHYtQtUd4UGYsQNhB+Kb5V/qKyDSIaqrwA=;
 b=HYaelbUA/ldyejpSZTrPZb/e19LpKxcttSUw+d66AK35SEnlklD5kFE4j85h8tQFHkdkiyevBRsrtg1IiaOYyf4eIx7CP6sjxYAHGyrlwtjiYF+Ezpa/Q4BezxVsTXSnTw6pLtbCflxO1lBmnqYS6y02qH4Mh//tkS/FRjCoP6wsbK/rqPc3ofRo0iZWyjGxT/72Utre8K3TYNouRz6ticFsg8Feku7jReq4cgcqw7PdoB0YRNToMgmgBnj87gvZ8YPWhYT3vKInmZfiuBz2IH4mpSrjlRBLiltACbSXcRhBUR7yGtiZBjr/ycSviamy9oEJJi4hn8YYVbr4qMvAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT9j/pnmlnHYtQtUd4UGYsQNhB+Kb5V/qKyDSIaqrwA=;
 b=MzBloUyk/o0HizoRAWobTgItq/dGHhkuqYSfdw7ofmLeXK3xJ3mx+RAz7M5ETkM+wPb7m1NNizM770qNPyhYVe/pnI66FDYFScH8XJH/uZYBTOrYBIDCfWUi53KvLPu3j6G4X4RCYE2VX89CLxA0VhYOpQm481Dtt0JaNRyFiiP7LRMLg9pRbxJoz0vNO/C7ngt6LBvBljZskrgib4AGWwCnmRStKyN9OatoVz3/RdUXl9WmK1ioGpEIqAHehyBWT2V+m5jI2iUAYQQSdvJxHWbg0850vonStwzHFn+KallGeDwogEytQSZ4Y1pOD3meFjBFhMFUXEBQRKGbTRxrCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 18:15:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:15:04 +0000
Date:   Fri, 19 May 2023 15:15:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 0/7] RDMA/bnxt_re: driver updates
Message-ID: <ZGe8pqKfW33/sQUd@nvidia.com>
References: <1684478897-12247-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684478897-12247-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c47788-dbd8-417d-6325-08db5894f78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkLRdJT06xFd8INbeOzvLkwSHSpFMif3dZOhK7VL4JPaM9GrMrpzzj9oBQzykY3d9k+QipBxZEH73Jsi8Ydxc9a/o46B/56E2QRLHZzQF6Znshwsb2dIPih3pmZLLisiDc0TjyuHTm3fJBd9fvYlkV1U5AasqBc+xqrMTV0kNc18elos3uMYqO3RabcEzB8NO74H6hj3e7Yywc/y/E3HETBb4foHkMDH+4S06OXG9ImXBhq6Lh1hqPOTvMtO9ggXp11bXUtf9vsVA80WinUm0+emwEm4skz7/qnsyEUgYQ//ssRvjgvnfAwlBVi5T16HKJGCJWrZnqzu0fuFOUeSjkB02uTUa3H6cWed53pqMiCgHFAjOzrawyHT/TCeKA/iqsSlWtx+9Rg655ti3AJBgxrZu1To48/oJDvjiqAGQgvXtq9J4iSkhkN9Du1sAdPwZt8/59ismDMxMYCYSdFq+0ztc6426B2HJF+DygjKFoho2WXtz+pI1tKBbwTKFVsqnGFualhIJPoMMgXlcVx2lJOubS8MzD4RphVzz8APn7mgIDZbCKMqD5ItDj1aBdpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(86362001)(36756003)(316002)(66946007)(66476007)(66556008)(6916009)(478600001)(4326008)(6486002)(8936002)(15650500001)(6512007)(5660300002)(4744005)(2906002)(8676002)(38100700002)(41300700001)(2616005)(26005)(186003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/SAV3vQIln1meA7ALezUgIyGVBnPHHLfW9HLxv4AbTcAHrWrr9hVO+jiGFw?=
 =?us-ascii?Q?navfiSs2PYCM5OMaODGSSTsy/wYpPyZcPoE164ZWoUdDkbVyoh3LUVuMPoCh?=
 =?us-ascii?Q?6dUCGcEmS1toVJhWFFHs9Pr1E+T3B2F9z5AWQvnf8zZTmheXzG4yskaV6eKy?=
 =?us-ascii?Q?UNW5UBT5DKOSj31k/iwvqx+JV2i8iyFTsolzep7I6pEsNQdfKi5hwAlEl6pm?=
 =?us-ascii?Q?8PXQvxOS7pMOCftl2/Ndtj59fduJ6TaX60iJqPGWm7YpAzpgRjQOrhEnxc9k?=
 =?us-ascii?Q?Zx8qhfsEPN7U4SgTA7SwGSTtzXkrNuVaPI1v7WbZDFe3TyLPyPhZBKCcqQ20?=
 =?us-ascii?Q?A8dY8A0cHS++j6z2h3h4YOhl9W7pzPHkdq7r5fH+ZBBMrbbCzwJpPELTDaf7?=
 =?us-ascii?Q?GzIsBJXUGaXZRk4TTtObrN2SRT7AcQm9IbwdxZBZWMQgF0YAxcKAexrdrarn?=
 =?us-ascii?Q?TB0eUlxeGgCAswTXlXrP8DjdquZsJSYoVH42yFu0yz5qDIAKdmaodDc3tTja?=
 =?us-ascii?Q?8LqhUirQl7lwxIpHXhp3V7DZvnzcxfiTgThPjRMKdQq/B+yzNB/FdxZcCfDP?=
 =?us-ascii?Q?GQqrO0OHi2/0lt/Okptg7qTW0TUieKIUT6XlMv+7kWNle3WMQ5c98dGkhHWj?=
 =?us-ascii?Q?1wnlHGhYpE2LnjFqz9QKPpvOEoavPxLTowh2NN0l/P2P/1fyxwGJL5xTLhzZ?=
 =?us-ascii?Q?ROwTIEXazCJtL10CHf/5auUrcyBueUnNDtdXOuMdZZrgWduwXzKg8r6k+eQN?=
 =?us-ascii?Q?tdbxKpzz9WfLWXDGMY6MYG2db4pIF+ISVXDfVew8BCdWfa0gPuYovhjwYmY9?=
 =?us-ascii?Q?J1CAzetX1Rp8Dn33bzHPS7z8HTg0wYRJv11ArRnauPePO76PtO/w4MOgOZQ0?=
 =?us-ascii?Q?fAgFm2BiQk1qxVjd0z6tLrxfq7D6s2rT9BIabW2iHsR+p2FCacO8bV7Foy70?=
 =?us-ascii?Q?cVFQlRuCVQPIsgEoXbfKpklGQzS4kh6IKRdV72UwxQqpoGYoZc0hcI3Eic3E?=
 =?us-ascii?Q?zkYhsj+Ar/ljpIddpkIuLzh9uuF3yPSAm4N+QoGqr9uvWBLVVhhIT94WgtIy?=
 =?us-ascii?Q?feV5oxUW7rFKoBqm3E+yl5Z2Xb9YL3yY04EH/PG3Piz+0EniBYsTNtIYI3jg?=
 =?us-ascii?Q?O5F5BThtkopT6VvtuT1dwRaJt0g6elT1qrXFzS+K2K7EOMAcZqbWbkLNOpkj?=
 =?us-ascii?Q?eHlPPgIbTb7hfp/sYFFFDbdKQLpp+4N9ZR5wXaLIJSY3Lhq2ecFzgfzOXJBS?=
 =?us-ascii?Q?EvjvH4FVmRBeRz17mMDHbxbYXLxlfAQ15BASPtn1lrFJT+aOvbOD0TmwvwdN?=
 =?us-ascii?Q?N2ZG1lvAFGDU/XiyukBK/+ED+FYS634zTH4CHoG7v66n7kogNbtxWoDSWL6l?=
 =?us-ascii?Q?riftdnNBbIrDfupQCoF1fitmbXa6FFONGfU0VYhW5IpBQVcnqFBHYQ3B3hH/?=
 =?us-ascii?Q?f0MMz/rdBHHLPL69wqpVHsjVfZWZVcmxA9SSmJkp6ZkqcbfST7S9/W6uc8Xt?=
 =?us-ascii?Q?3XwPP+H9s0/xAT0iTfk3l4CNMoWtTJk1h/rst3T/4eX/gdBKZT1jPxQf+k6x?=
 =?us-ascii?Q?lTElqKihRU5K9GFZ1cC+mgGbSPx7Kl/ZNbit3Q0a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c47788-dbd8-417d-6325-08db5894f78e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:15:03.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWeGlTwnjnRQ5IyD8EV0GR82fIHkeX2QmSYYNHWVU4wzTdmpw+9pGNy24OF/a4DX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 18, 2023 at 11:48:10PM -0700, Selvin Xavier wrote:
> Includes some of the generic fixes/update to bnxt_re driver.
> Please review and apply.
> 
> Thanks,
> Selvin
> 
> Kalesh AP (6):
>   RDMA/bnxt_re: Fix to remove unnecessary return labels
>   RDMA/bnxt_re: Use unique names while registering interrupts
>   RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
>   RDMA/bnxt_re: Fix to remove an unnecessary log
>   RDMA/bnxt_re: Return directly without goto jumps
>   RDMA/bnxt_re: Remove unnecessary checks
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

Applied to for-next, thanks

Jason
