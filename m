Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A87A8E03
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 22:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjITUwm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjITUwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 16:52:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB6BB
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 13:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEfR5PG32U0hRRo6KAashv6ANPtiVNPe8Wv7tdfvVrTHIcm2dKyciaAgbJaH3GtSi6A1+HBHvhbRnesA9Yb8HRGGyjSrL+ERNGSx7bByQ3sUm7j7uFdimeoqkQjlUeCSBBDCAYyJX8exovm4W857YZe9WGxo+hg6f7chro3DFulqEgy1THpd33mKa2eWitm3gssXTFQr0FvtKdzyagfw5QV6geAE72XGUO4XtkiM9vmyfKEcX+tP7o8vlMg3tiiZXgfSt5u1LLQ4lqEk6BTVtF3E+jq0wJcmhEyCa/dFaKa15nrmnB2hb0Jepon/1US+hBNcJiqx+49SOadXfE55lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8xYlK/C+z3pC/gxdJFwzXDBDxmOi4nW6lByLbRxfFM=;
 b=GABWkQvsK7uagP5+PBtgdR8D286eCiqsxOCbn0Oh9TAvffBzRXlprXeWrO721MgBEgvxhxUCs8TwQ8A82+6xDwBgfNPQxiST/iFIwlZ52aUGZpewfnS7QC+GZOrXemmF4qTQRIcGIYmAO84Xro0CqLqTzgTj3IlOyPkZ5jXK6Rp/nMFuB4WJzqPCPZaSFarwVcXry2n0wZKi0cLDZFm+HBZQ7KQ5xpd80LEDJkHi1+skTkpkH7883r6kfO9/w199eUg0bAtyn4iduLyh0GLO+MahQW3JorS61dDVOnYaXDkkSulhe+Y7ZD77tZHLJhRxxfNb02fKs3FWV0S50YRlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8xYlK/C+z3pC/gxdJFwzXDBDxmOi4nW6lByLbRxfFM=;
 b=qolMqnCxtQ5B0Zqik1kmw0uQMmbO1I4yZxoa/cHDXzEwN+E9zw/vljs6iORwP1k4n1demlLtmrtjNN3tSRaicxWllW2r/5wSSmC+4yhojlzrkRxgXZeOcQjxwCggFLHHM4HtwWh4QJt0yMYmdPQBZj634Veox4gNjjKo2wwGun4OV1yMqVjnpqRCKHGbSlrl2wG4AhkOJ1sfWxWZZE4dP6WSyl3jboIJISaavDkZo+DfcaI7TWzKGl81ql1IJ9MEyudbvE+Ktaa8IULQ8kHTGV+orz4V6gmBt7bYKuvasKYZEZXf42CQ039tHQduhs7RdFA567d6+zQmS2Xk/QpUNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 20:52:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:52:33 +0000
Date:   Wed, 20 Sep 2023 17:52:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: help with performance loss question
Message-ID: <20230920205230.GK13733@nvidia.com>
References: <acaf78ec-9c88-572e-9c65-29606f5a895d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acaf78ec-9c88-572e-9c65-29606f5a895d@gmail.com>
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b2735b-c27e-40f0-dca1-08dbba1b8365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o67gE5e/Twh+EbKpNuIkgwiTcyJdqz9mOrwOzhH+NwLwu68lL0i7CKXRARtO3IeqBDiwZxkNYPl3xwzYouLHNjcFmfK/TiQ4lNGnHVvp6C3qRXiwIFSmnBkQ4MQhqlTU7EBR4wJs3/xRTmWx/gA1P/W48Bet0wEhRTtbmRcOfbUEs7SnB97+oo/lyd20YIkytpkER5eXmT4AKBCa7sjHagcPg3mUGoL3cxYv1e1xIQFlmHMu4VGdzR2R6X3SXCVSqJQJgXDt3ATm7o2OvCoF2ymVCW5v/DpowPQbepMbdiEu/fhnUR2ZQFvW/pTdwgBDW4uWfzxhHSRpHL0VoEe6tA7ia0ZCPB/Hi0S31tmwbZg6lW5NDkvJdMfwrxACdtpPzdeRXMmS9jK8TW5tMjHfzFATt/AFTvM0NdwBmpmUDy6QkXyCkHbZzN3DmtRqLRN1OAEUdQWBeX5b98NzDqQbDxVWNBIfzYC8OfIFjX1FA/0MPLhTTBTYB845fwaEoN3e+mjJThmVE3YRzWALMk5Sta+kQvKmOOUfPMof2nl99V40y5yB7/JtVcQ7Fq0aKXnj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(1800799009)(451199024)(186009)(6916009)(316002)(66946007)(66556008)(66476007)(26005)(1076003)(6506007)(36756003)(6486002)(6512007)(2616005)(38100700002)(33656002)(86362001)(478600001)(2906002)(4744005)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNQX3nYP8XIFJuiLn+gzUnYAmbLVBEe0qz/lF1R6waAAnURdmQoVJZwTCnhJ?=
 =?us-ascii?Q?tviT3Ogz5sDH5nXsJmICGiGcuZharKuFqvWB8xpQnzZ8PcXDEi3zxawI+ZWp?=
 =?us-ascii?Q?gm7OalNUzDqFkpsFCbXd/2oT3iCN4XximBYwgTkAePdkvT6R+r9Ao/xa5vwV?=
 =?us-ascii?Q?FzLGCLodaPx95ng3sjsr88Dtnni/fkYJnSs8/TriT4F1BUIdQAIo2yacdCWs?=
 =?us-ascii?Q?JBmev5ZmsTVLjldP6x8mUJXAXHRupeHMh+osYhLdY+UwLmtU2caSDA2SodZJ?=
 =?us-ascii?Q?wG+5hXfVfsionKh5/wzkGNLnx9BKJx4Wc++Yh6vLdKPr11Yj1IqWlthZHz6V?=
 =?us-ascii?Q?83ygvb5aXROvgSokx0qI3GuLrWBnTvXvXJFuK7dXkN1NednJNYHtjE3QTGFP?=
 =?us-ascii?Q?NLlJWrobIVvtLkP8FmmN71CSFBPp9OY4HX6CPk4VGudl5pG5ZYp/iA2GNZwK?=
 =?us-ascii?Q?32EqeUER2nvFLNofOCH6Num/bgAtCP/sjr8DSFwZHZMNTw0hunhAGdiVI8d9?=
 =?us-ascii?Q?gQcD/rN2b1KHbEvX5/uIvMpZO01jsfIh+epi348SIGOg0DYVkEDqRpzgEJsq?=
 =?us-ascii?Q?rW/Hmh98iTwWk/kEba6/tKakDo1NJ3Tg5CVA/PSljDO5MNWyumAAQQwQr8B4?=
 =?us-ascii?Q?1daz5Q2slME7PSy2PTjBY2DjCunaR77BUSRxM2xWjgogPGkiBQ/UDpt23ptC?=
 =?us-ascii?Q?bqdrDGrDLTwMi3bdiaDPL+QC97EGY1pwp4lzAtiLqwywlzZPxKhMchyyQSuU?=
 =?us-ascii?Q?Mkp/Rq/dO8cGrlseXaInCcGZoQsDv2ZVgLKnrn0dH+mIWadYsEt7UC2nrd9k?=
 =?us-ascii?Q?Dn+rKJ2e2/oWpmMOodDXB1L5TxZGAh2eIsDdWiyXdKn+yddSPWCJKLWR/N9F?=
 =?us-ascii?Q?ldDfqhM5r15rLVL2wr+LJM8UxWEzi39fTSC1yiJ9wgoQ2K7FSWc/RyMHy5Cy?=
 =?us-ascii?Q?popaMMtw5Xb7T70y0454+/0T45PVjznklJSTDoOMVl/XeBh8mCXNFtNnMpPS?=
 =?us-ascii?Q?SAVmc2srOxF78ukRCw51/fY10rGWPpiUvQjLrKveebn2lMEnUg1izoKi6zq6?=
 =?us-ascii?Q?PofPktucKuaduaFdcn7wW4ZBr0/Pt+IQn4FgoF5koAAPW2i2y6Ubq8VJzR/c?=
 =?us-ascii?Q?DG0gCWd5VHgevAqjJTstBqiqOwv/avuk53nt5fIWzobusEe1Ak7GQQUOT2SP?=
 =?us-ascii?Q?I+oP1W3251TQx9Sro7CYYXjQwKDMl2U0jDoWMrW6zxgmbPMFGApiClDc3RCo?=
 =?us-ascii?Q?hYlkMpAbPvoC+7HpxYpedUTvUe5ninvX5UcjTAixm+n2BjrXcm03yZy6YPng?=
 =?us-ascii?Q?QWdkJS7+3NRycqujv6ij4OyYjxw5olLJw9U3ybfU6l77tQl4ByKjY76Svuf+?=
 =?us-ascii?Q?5Ruh2Z8AlaU8ffNJPQcn90gXG0dsBSczFPz5+WTCk5UHVFqMpJH7PVAgRyHj?=
 =?us-ascii?Q?u2Z/Peuz6A8Zyy8HJd5W8Tifhh5Tt+adI4SzSAMTF77PgA9nG2aDB8mJnKlV?=
 =?us-ascii?Q?Ex38yL0nmh48qccixox6EvK+C7a4TZ588Ry9PI0N8nua1MYr17k7kWGmaA/R?=
 =?us-ascii?Q?+Ooh0qcaFz7oISNcdwwSnFyIOy7yLR1gGJrcWXFb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b2735b-c27e-40f0-dca1-08dbba1b8365
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:52:33.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyUpo+TZoajsUb331h1X+sMd75/kP2d85F4SEIOSBnaqQ7xDOnJfQxpojB80LzMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 02:54:42PM -0500, Bob Pearson wrote:
> Jason,
> 
> I am trying to figure out what caused a big drop in performance in the rxe driver between
> v6.5-rc5 and v6.5-rc6. The maximum performance for 'ib_send_bw -F -a' in local loopback mode
> dropped from about 1.9GB/sec to 1.1GB/sec between these two tags. I have also measured the performance
> of a 6.5 kernel with the 6.4 rxe driver and 6.4 infiniband/core drivers and that also shows the lower
> performance so it is not something in the rdma subsystem. (In fact there were no changes in the rxe
> driver from 6.5-rc5 to 6.5-rc6.)
> 
> If I type 'git log --oneline v6.5-rc6 ^v6.5-rc5' I get about 360 lines but many of them are merge sets
> that can contain many patches. Is there a way to list all the patches contained between these two
> tags?

I recommend you just do a git bisection, it will be more robust and
360 patches will not take many steps

Jason
