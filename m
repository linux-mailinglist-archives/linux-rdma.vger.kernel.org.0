Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D455E69DB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIVRr7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiIVRr6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 13:47:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50AE8DA1;
        Thu, 22 Sep 2022 10:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPQl4+ymy8kKrvPcjOekJXkP4zrmdSzDXAWxhYngoJioEYNWP4ukVISRjAsEvubaaoTY9KkPRaPhEgvWLiSMwEoa16+yZqNVfJxhDMVhLMHQCCRl1wKzGOUn2vPtbKCqxhsOv+8BwZHkU1jGg7tM/x1a8XWcRS+RR7w6tOhxjPLCIM1phP9EGxz/5Fnkpmer8OWybI9V47/+NYZmbBz0MkzjCS4l2G8t1mxIPWv0Hw65j6HlZLUyMdaFqu1N89eAkA1n/XlaS7KQ9iNz++O/PCnstyS3D8yJH9PUFIpzAGlp1N5SZ+falG9V6uuZBzAzptKT0chEBMfyHLhrJwDYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5XzdLG0EtTIlUkN6LEuu6z0AQGd5ksJkE/BlxNmCNE=;
 b=Io2Ft/KmyVuOPGTWA6isGaDp4sp4Nu794XkvmH9FBo6lxeEj5bzERZwUERtu3nCnbbEQIvLojw/v/uXIFyJsJCraM8QDKJOYCHC3Zl8LbfST0m39h3Z8gm6OnKa9e8otBHZ+39FINIDuLpCHVhzPPjY7YkX7hGQEZWLfiN2H0xvGwcrm/NHNjgSkNpyz+fr4IAp1zGkCJ56afvGk/T19jaNdS8smXekVemXOxI8Uc2XkMiHU98JXKHmlTKaom3w3lJmeEzrW/EcfQiet/FGDyo7jPK+p+ODMYnGSufDLir3NiLPC+zYgFLZdi11WweJiJqFg9NQZLmHqHq9pI7+zhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5XzdLG0EtTIlUkN6LEuu6z0AQGd5ksJkE/BlxNmCNE=;
 b=bB/UZFXAjqYjVULHGjOrG7rbhTrR1pAnIkNbg5qSxjSOb33wqxuZsKNsqijfFuJvkoY9fTsoptrtty1uYFJ0sGBvymlrMVyMVExRSnQpA9q+F6YVxlaSs9YMOm4HUBKkwusUW3uHXTIzm1bdfbmVgGjr5xj0hNqccK20d90HEtXoZIrqB/xvCyvhD2tqlTIZ7VxdzivLVi2aHkUXHlL9dL+c4haDX0IRfm7zo/FKDV5sejp9n738qBWxyNO57kjbAI7Oo/Go2vlJLS3I6R1uNjaCQ8n9qlZHwffssnPwGDrBpbD5brtnvu2rEtmRdjr59iW8XAwsqjcNPv2iwlOYpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:47:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:47:55 +0000
Date:   Thu, 22 Sep 2022 14:47:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     jianghaoran <jianghaoran@kylinos.cn>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT
 mips kernel when enable CONFIG_RDMA_SIW
Message-ID: <YyyfyqJhnofsNQW4@nvidia.com>
References: <SA0PR15MB3919C9E8260E7DF5FB36A9D9994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR15MB3919C9E8260E7DF5FB36A9D9994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0c889c-26c1-4c2d-4522-08da9cc29440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pe/9paK7Fpdlw9FGQFPNC4rK3+/TbFnbsHn52WmH/vKWxf5h8HfQU0wRktpEdqb/c34FL0nuJsULyASW1Nah+BS8Ff8ZVgnuqrBmxecumTcO6bVRaPZgoyKlLU0euavYiJH7mAzWi7zvq7ZLxuDwudvy4NaM9o9LiUyEOfg5ufTnZulYZB4ofQbmAYKclp7GMom32KX+htyCjq4VhJCS/dLdG+Kz6BP/aDJHpnS4l/V1sdBOsIQw9qD5WeqQBCrFjOhVmDo9g6KHN0b/wXmhfPOpOBpGTw9eAIkkCZyQdEqv5SRf321M8la3Qoj5U5RP3SG0Xqdi6X9a2YDwNpLVVC6qObDrYRUyPt4G0r1L6FqQogjuhEkbiUEDsaHNQJn4sWrCQvvZWBrsFy7FwLlPgIyX5s7V/Ip9dVlOonTLe0Cn/hk7/358BYkTOwHNnlHBzzLoaPN4Go4zML/pdVhgyM2nTYQunp9G/iJClMHd4d0fomGwFi3t+vqaXJFyeJXv9tv3YcWyPZgAEO/tVJzb7Za1y5zuQHKyZA+u34WFT7HI+oEUwivYnYi4xaZZaBNzml9M3dLMeDZdwfuAxxEpOYftdi8Ndf+DFcmTgrHCJqK8ZTqDP5xj4NC84/1ZmPzXzYicfnQjonqul8WiRHfaRZBIZ+9oP27tmnm3cXbdosWWJGtY7/i2cH83by4MaRMnqvFrNlRdp+e7tMimxen4rqn1qdzxOf3t6ggtcwakA3xFCP/b/IZjdQ2CgvWp6PpIFIAIhqofIAVZZBCRk/EBa0ng1JsI2wyvWuSIY4JPZNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(8676002)(36756003)(6486002)(966005)(4744005)(8936002)(38100700002)(186003)(2616005)(478600001)(86362001)(26005)(316002)(5660300002)(6506007)(54906003)(6916009)(6512007)(41300700001)(66946007)(4326008)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZx3GRDv2yRiJMyU5mveesl4yhelMr//nELd9SxjqAODBgyrpQRbSSVyg1Xw?=
 =?us-ascii?Q?pxMfGO05KhxyDTOI/PggpXZOUOkkNkZcZvjlmJ8W4/AoTpQTqOykqDqE5w1W?=
 =?us-ascii?Q?hOoZXlQE5rZMX14BzIJkj/uBahJ5p2rO0/tD0a9qiDB3eDK6BhTDvUps8VG7?=
 =?us-ascii?Q?RAyRzJsrwdJvpboMrV2kDA7eAfA3mWPcOcYmTz0FfdJ7gHfFZhsinUTTsK3G?=
 =?us-ascii?Q?7nvW1hz3VwoWtXrUusCteh0jCNcuR9f9LyAm6OMGZ+aqlDskYXUlKr6q3rxt?=
 =?us-ascii?Q?fPpjHkXzeuGKWLU6QYpkReFWOyn4GmYOiiUbyVcatkiA8D8m427I0H/sj4Yh?=
 =?us-ascii?Q?2bLEKtm+1Qsji/RkXVRtKAJ9kkel7ZosnXh0LN5EJmX3W7kh1gfS1TiDiZm5?=
 =?us-ascii?Q?Z9UknLgkjV31RUS5tntdnSHFzA4FuaRWK4yLWYxUoasqSlZbewpcdPosWLsd?=
 =?us-ascii?Q?jyAHV9Plz9yYvKIBAXkU/pegMgEkuV7y9+iW+/BTgT5ydrz0Fk9RBDnlctpa?=
 =?us-ascii?Q?Vi2cYMFjV9AdlqZ5mduqg6ysL5fzAKJAmBVWfF50UbKJJhMX1PlK6RuwtMku?=
 =?us-ascii?Q?AMvK70pUFoP9YjDY4kIo2q+HAtoJ8izzeC8VD7R0J7YTWadlbJG0gO/QpIjf?=
 =?us-ascii?Q?9jIF9ei7QvYN0S1TGFUoWB+ZsjH2/+/dUuNPpBQenaeq2H2Wn2vykuIsTAmk?=
 =?us-ascii?Q?PCusHnbx7EMUEA8q7634LHxW7wEiZ4pBz3HRjsyO+xaNQ8OA4K6+bse6NeeA?=
 =?us-ascii?Q?ZnJ7j80jajiSslCec2WzOG/QA/WYvHh0EmbhIdHbrUCUU3Wyqdri9u6RG0ac?=
 =?us-ascii?Q?AkeIdzc8TVAJqbaH1XrINzzrIqNNvvRE7XStnCLEUIMRfFZqwUiJI/ekr42A?=
 =?us-ascii?Q?yScE1BRbR5QF5MOafXmtu32yjpNaUlLJvcS7BYWuFojcMsZP5SzLvpZ8elxv?=
 =?us-ascii?Q?bOjdP+eh/00Qo722M5+ZXIWKgIg4SVbf2PN/5U+KycQe2G8Ct6+ecj4MPYRK?=
 =?us-ascii?Q?rAExNCAR7Ru7PTnr9/+3WbOKBIAXkg+YH0KaK95gYQm4+vlJAjz5ixyhs/3B?=
 =?us-ascii?Q?1PNo09ZIOIKYDVYOmfWgcVJ+k4VgheQU6TdfYBPhWmRujjIL+0JnZsNytMI0?=
 =?us-ascii?Q?YMI166+qpbngRDztDN4/rdYLVm4dv5UfgsFqrOYE8OBVdQ9UOuMu/g1e/3E+?=
 =?us-ascii?Q?eiu98GteDMquzn9ZK9l2YU0eUa/KsiBu+EbYh03u6n8FfUPPWXEGiCgdrb3G?=
 =?us-ascii?Q?8k1NUje/1dxABvOt7NXHqso1xAPbU9RJok4WjuN+J3QdiW/EQPmqr4UnEkOA?=
 =?us-ascii?Q?3jOZaHOCTJArpM7HBPYJ73RGS9lSQL/F1cqgSfhQGVMcVMci6pr2JheybyuW?=
 =?us-ascii?Q?HPoKQtevw1kAn7CuR3I0y/k0UuKKt/a86rHf2FzjBMRphvbcmKNwgV+dmTzp?=
 =?us-ascii?Q?k72isel2NYq4VLg3hcLkcsNLk6A/wZbfY5ENmYdtuEhqh1zQ68lK3msYnNJz?=
 =?us-ascii?Q?MqD0ovfD4DpAS4tYUSdN6btJi6gZLZCU5hJ58TBabqDnQuBXGI82x3ZLi3sn?=
 =?us-ascii?Q?vqrHYHSZtxYLUkSw1YdrCBSbamedyYSmDa8EcYjC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0c889c-26c1-4c2d-4522-08da9cc29440
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:47:55.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvwQr96OL4phiBLxzd5XhRpUGls7b0YmgI9NcoWwjBUhuqYOv3h1M4HKHIpo/+Ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 22, 2022 at 05:17:24PM +0000, Bernard Metzler wrote:

> > The compiler is saying it should be a void * not an unsigned long.
> 
> Linus' [Patch v3] was moving it to uintptr_t  which I think is
> the right solution. We went for that afaik.

That isn't what I saw in merged patches:

https://lore.kernel.org/all/20220913140416.280860971@linuxfoundation.org/

I'm confused??

Jason
