Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E767F20F2BF
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgF3Kbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 06:31:36 -0400
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:46304
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732238AbgF3Kbf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 06:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdlXaGPUenyEYAx59fLKCbxKpxeEecy4eAB0qGpo458gr6zCg5KDHD5hAg/mrFg66MRdgiATg2AUPEb6y4xa0/4o15JPVqkREHNiREbNaaeSkPZImCNr8C2evmqia1AIw7A6ti0q+TqRIjNTNbt1mszXn1E3aX4sgUEsw/iYJvi5qvou91sZkFAbgXp6clKI+lTZqw5WOkzA5gZXXvQqbV5/NG8JHOVU8FImck+kNY8OCbyIFTxrwlE3gkTws/b9jvsucN6KPhebboyShK5Kg9S5UbXOwTvXOnTbcnZkjfCGwfQ7+F6EXO7Xcaz58zCME4iIpUthk9+0+wfpQs4P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyRDwz6Y7iddc06Mjo2SiVeWdOVJG/EK3z5NxujWFUk=;
 b=ZPSEpkOz+C284iiPWvK8kZsefR8QKcu50bE2Z8N0ogsuBIE+V+CHJXBWsyluo++GhCngPZo6CQiSNjlpWnr5DLcDa3VA3XFlgmu/Rz/FxpBXYLgd4khV9n9SJKeeD9iwOaC9rh5KKMsSItifUCTvln7GukMz2AABpObsvsHPygvwE50YOBRCXs7RuB6bcfj1IzbmldxsUL7l9uDXCvY7K1dNbgvDWYpNv0lVVpqt7vuHSuk/Mp+2PFtphG/uh/SeGmZA4SLwUjhrteM8BKTYooupzQg7zK11KNY8BEIVokhwwiysDo8ZAK/VDnDjzy+7VsFPfSAGZFhpO4Du6vJLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyRDwz6Y7iddc06Mjo2SiVeWdOVJG/EK3z5NxujWFUk=;
 b=UaLwgJ0ZdYN2UtClPKVibP0XuRA5adwViv/lNV9SUMZmdcdB7d0xN15EqZDr+ty0aundx0iYMRstlwffDCvhK80TbNhCMonnvkgF8pkJPtNcVmzZIooeiA7JBG5rm8I/mht25wbF81GH0m+wdoAgmlQbqKHt1AP7OgsMHmtALNo=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB4902.eurprd05.prod.outlook.com (2603:10a6:20b:10::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 10:31:31 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 10:31:31 +0000
Date:   Tue, 30 Jun 2020 13:31:29 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Alaa Hleihel <alaa@mellanox.com>
Cc:     jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Edward Srouji <edwards@mellanox.com>,
        Honggang Li <honli@redhat.com>
Subject: Re: [PATCH rdma-core] redhat: Fix the condition for pyverbs
 enablement on Fedora 32 and up
Message-ID: <20200630103129.GF17857@unreal>
References: <20200628145003.13705-1-alaa@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628145003.13705-1-alaa@mellanox.com>
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM4PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:205:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.12 via Frontend Transport; Tue, 30 Jun 2020 10:31:30 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 956c1c1b-e396-4a97-bb12-08d81ce0c123
X-MS-TrafficTypeDiagnostic: AM6PR05MB4902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4902539ADB615D1AB6A82473B06F0@AM6PR05MB4902.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aey3gJm1BPsJXh2dLXjWySRx1/pGi3VBJNHs2TTOd39YvjSfhPUj8MxRTaZE/aTPW2m5BlolJaxwbR4dTs2vu6uC4wll9PcdKY7FRozyjFc7+Q8e55+rv0ankJnKwD6YarUHUK0rVs3Wlk8JBfMINzMAnBzppuef2WwqDfbRIVgkWTzItVrP7PvnS8NA9I+g470MazoYfkMl3cotC5fCjKSEYrwQ0SKjttXz0DJG7eWg9roqKOrqUQJj29zOO3uNBJTbFryuMScMFLzFU9Y+/aYjEJTlBuF08LaNq9RT7Q0UZPYhKqzCUEiDy21c8J8P/Q84jKqVgOwGK4htRhbnUwAXBx7/JZW+fs388Sr+UlyFiVl9kQZEOMXCOAbamWVJVfin5zSVYDeevFeoBz+Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(366004)(1076003)(52116002)(6496006)(33656002)(9686003)(66476007)(33716001)(66946007)(66556008)(2906002)(86362001)(54906003)(4744005)(5660300002)(966005)(498600001)(6636002)(956004)(83380400001)(8676002)(26005)(8936002)(4326008)(186003)(6486002)(16526019)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S95CRrTW9PJkX8L1pHTpJ0pTQyAZYnjZ2A1kusOp7Pa89BFokxLM/UaxwrroJTZRngo4V2MtQvz5eYORaY7sUkapPEDcLBPACduymY9g+w5piQGWnPA8hrNMuZaDmDjAq2Po1eratxcvHRViaJKbW8HjIWZXzY1IJpK5d8PhE8FlMfteZXa8uoquNxx/al7lWbElfSlc+VDJ5zj046y/E+3vclqaGiUmRgGSQnS+1J1hDQh46HaddTq0RWf6W0EaxY09Uyyg/57Nwmfa/bxwV12BpXA3uJTKCV331YubAKJ8yOulnqjvZ0EbG073dUqoUzEXOLpwpqmzaHM81VSBZBT1fkI8pzJrLj2aKDBwxv4v7fYWbb22oBCLTPka0/5HD8NLY9oQqY3s5QjCYOACvu0NKXh6yxTU3wUl37aUQNMNH+DqOUBoDxkuerDpWpuSy+NY0yC4cDSWBtSVOBa7QPBvwSlO8btLEuNP8LeJiDKKpWMYKfh5bzn1x3aDAa+0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956c1c1b-e396-4a97-bb12-08d81ce0c123
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 10:31:31.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cY5jeBe39tza9bTZsrroucLhfhpA4iUD+kRkz+RynoRcW2v/jbkH+77QS8nS7C3Y/ob/T8ixcawbxuEIOyLGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4902
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 28, 2020 at 05:50:03PM +0300, Alaa Hleihel wrote:
> The cited commit enabled pyverbs build by default for Fedora 32 and up.
> However, it broke enalbing pyverbs build when passing '--with pyverbs' flag.
>
> Fix the condition so that now the behavior for Fedora 32 and up will be:
>  * Default: pyverbs enabled.
>  * --with pyverbs: pyverbs enabled.
>  * --without pyverbs: pyverbs disabled.
>
> Fixes: 07b304b75186 ("redhat: Build pyverbs for Fedora greater than release 31")
> Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> Tested-by: Edward Srouji <edwards@mellanox.com>
> CC: Honggang Li <honli@redhat.com>
> ---
>  redhat/rdma-core.spec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


I'll wait for the results of this PR and merge it.
https://github.com/linux-rdma/rdma-core/pull/784

Thanks
