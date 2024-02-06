Return-Path: <linux-rdma+bounces-927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7727884ADD5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 06:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD08B23485
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 05:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A687CF07;
	Tue,  6 Feb 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJn7+u1a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10277F3F;
	Tue,  6 Feb 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196421; cv=fail; b=FLKEJtWqKZggaa710d/iEjG7GFAT/9MdZZ5PqRRYUohxpzzlG2GP1rYyAlvVoEOak9JFA30OxXYPPHD+ajoR0umcYpjvxAZTglZgt9pUUqu2IiqJt1vZLr+3jj7wCOWPa4jwJtuvX40SEJlz8Ea1MY3PfO5XvQE96vqNMBxoY54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196421; c=relaxed/simple;
	bh=quVoHj7MB0wO07N14htJEMFHUEfbb/MXREMoyJ1GaUY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=MI7/JyE7BsZNikXlZj6tgJIqadfU83VBSmYwh2us5Un1HGk/cebbHLgTSrbzo1nrajJD16qqgATIS5Sz8Lc02td+JCyBbdOX3Y4D3frOBhFL/r+FTdLmhocs09pTvhDTmsFKW/5NmmWJN02ay19T3zUh9WSdtTcbvkEQCny5Hcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJn7+u1a; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glsM6YzV8jQeoBlsxknBS7j/jnWWLvGXLRsKcV395dfNHTrWSvzB/emFW4EVZFJRBPryHt0pVRc00dMPPs74NOXH5r1FpoECznD6PlU4GEaULz/UC+VE3/2JOMCQZ4F4UB7dRKL0MHEgP5ibALKpIDW7RKJ8l5I6qu8+71yxQ59ye+Qwjs0XL/X3wIC0vmUaYCDJLxfYPU52jYJmU14TgJtnPT2ZC0jE4nRdM2RLzifo3paHZT9XVvrLX45jtQBuXOQGXp9v9i0WLS2qpOYPnIrYD9tS3PuLhdQY6COwsaRrGBrcnIhPm7PhgYa7NdpREmbhnE9fgBEEgpNItBKJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3WeQIY9Ifnr3ayTqeNLpWIEVxRXHSp5F5ZuE4jGEYM=;
 b=WU+Agh1wQiFSlotUa8Ktwm/xSBULOR+YDE8RNDgwT27KhnrYjllJfGA9d9q/v624ldPFCOcqxmUKYp4D74XRY2YSnaLVPwcwH+n3xpzw5fGQUqqIv1GXZU7NDvD50aINjVIZ7aqYev/qOuaSfZy5zDchwxDrXQDF9XB/QbFsI+onp5VzDkCXXUDl1hjdYABp4K4dU8uv3n1zWMEQsgz23wXXWw1KRaC8Gq71gLXVqPaulki6k6/i69h5YZ7cItPP899SF3VRHvlZ/fLbNkMV/cKiRlDznbmIdXfzjS4Z02ZyM1HLcm9CtBi/xdt8KcGkauxZNVufbVLbDq7w6jKJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3WeQIY9Ifnr3ayTqeNLpWIEVxRXHSp5F5ZuE4jGEYM=;
 b=HJn7+u1aqAutOxeGWK9cXvHBFERm2o3kelA7Mw5dfyrq2G3fYibVYt29Tv6NTyNSqGQx9/GM1jkXFwxp/IxMx99U0uCUjiKO47eFTPbwdzay6qdOn/+fcSwV5g2qT9PMV/8EV42bruRxKx/Rr8W911SYeDjQEdSV+Qox85RmK4EWJMMtq9cw2MbhSnaLAch4ufH/skF9BX5vPQEBkpIWjeGQwGoAIvd78Ui0lGm9aGbaPADzfveE48TxR4ZR46xFqJV4ZqlIvkb5uBY6vewACI8iSgmSLn+Wgwr7PDVyZ/+x1yfG4W2W3erHhGgMRCjPYhqsLrvBAnpERFbbG6Snnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Tue, 6 Feb
 2024 05:13:37 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 05:13:35 +0000
References: <20240206024956.226452-1-jdamato@fastly.com>
 <87o7cul2nf.fsf@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2] eth: mlx5: link NAPI instances to queues
 and IRQs
Date: Mon, 05 Feb 2024 21:09:19 -0800
In-reply-to: <87o7cul2nf.fsf@nvidia.com>
Message-ID: <87jznikwe9.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 692d841a-bdc7-436d-428a-08dc26d25ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FodDOprADJwRUFA8AdYwnY4j3rjb9lFZLknnP20T5Iov1DS+k3ewTkM5eFTANxWfe/+54+HgBpbHAoi0k5C8YspDzRjp8iP+X0fMaGFFsqv7zX1HQW805Quxz5mEp4EZkUll4Z29/7fjG5pXanki/Muy5qXrdnMniIyKFy0bh1nh0ReoFQtwp730+Ln2ngvT+gY/VMcl1rK9u4Yg3ZS79McWqw0q7TO8t1A/tWwLSdwn1E2fePGKrwKHZZDEzdV/JTy2JOyEMbyWApYPB24BFHqwbOmmIYwZRzp5s0dLnJSBfCpm5M9VYgnWa5iBueuyQkN7lVQR+22z8UrBmeFITsDfCEo9uz1VMo1yFMA59A42LPJv/3LfzhB3F1jM/EjiuYLSV6pNg3oQ0TjKSK9az6H+UnL21LCWv19xKQE5I2Gk9Zeg1BFyA/sav01nsaooB5OO/Ce1hFIJEMuJS5LUG1Jg+loxM1dPo/Tm3OjcSEwETepjbLQh+0tV/eELP7bCuDr0pQVk+JSX3VzE7pn7PdArD5uYgSUxpS4RPkuU/BPPb+MZMT/PDX3u1M74PZoA07/TnzIGhemqoRLurL7OQ1rYWg9VABkK5WrG3l2dOEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(478600001)(966005)(8676002)(6486002)(6506007)(316002)(36756003)(86362001)(37006003)(4326008)(8936002)(66556008)(66476007)(41300700001)(6862004)(26005)(38100700002)(2616005)(6512007)(54906003)(83380400001)(6666004)(66946007)(2906002)(6200100001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lpde4gVqrpuAKIxhnjGIlu8tPTCebCORMXl56y2Fq8OoUVJhyDgcLCKEUAxQ?=
 =?us-ascii?Q?vzAJaadY6DjkBjW2EDWgPeZG4FcOyBR7ZHBXiut8XTnV/czPh+cMxMrwnoAC?=
 =?us-ascii?Q?hvzORpRurcKAXKmzc+uboVXaw2KQoY9LZixoVwWiusSk8JH4WeIOuc5iCPxh?=
 =?us-ascii?Q?SCkCRf53YcSGETV78nBNaqCNa1y4HO8qlQDXVbqMLhAH6gl80V5fMFEfuHQQ?=
 =?us-ascii?Q?SvpAhjUQKRDz1WZQbFk6oUwoI7BRN71xWEV2AjGPowBnbNGCV6SMghTP9Chc?=
 =?us-ascii?Q?UidPIXZhvMF0qlQFDkZFIHdZr1/SjTZvd+APnjOGBpc6TeDIdIf2f2pkiixD?=
 =?us-ascii?Q?M7HnMhWQfxhT1VUn9hFSNR//JEk6M5acxB63aD6l0OAc1UTVBfwIbLCQb6lQ?=
 =?us-ascii?Q?qH7GwiJqknzFlPnfIXuVlnq3ybSq0VmJdCRakH6quYUyLQrYlzx6nQNICGGD?=
 =?us-ascii?Q?ERAw1Py/axG9ZUWoaze5/NkYyr23HDuJj4FlshEC89VkHeGos9sVD1ERIUMJ?=
 =?us-ascii?Q?xqca3aN21k+90qamlLgCnCEYdzlpRZq6YYZ6VUzcJsNqYAfp2m0KVRzhRWve?=
 =?us-ascii?Q?dyleO4hFtx1Ynhe1tHEPer5IQCeiGIBSoD/bENJq3PXFErK2m3LjZ38eZUrQ?=
 =?us-ascii?Q?PPg3Nauj+1bHjhwgcUbNjz0SlCO/wQCvdXLxLnQIZS7QbL8tYdg17XDP7N3c?=
 =?us-ascii?Q?nz1tjABSjTTWjXtQhMFm4kFQr53XUgnnQg3Xh5JebNyzXnQ4N5pdnAobD9Ol?=
 =?us-ascii?Q?MKYO9NdCybs6763DJeV0hAK0DJfBEl3+/HvQ473WriLbHk5pjLaWpBNPEs/2?=
 =?us-ascii?Q?ULTrfsSFDDL3c0wh5sHPt4xdgPs5LqqNYs8FWPQpnPSe5caRlp8pmVjIDQPs?=
 =?us-ascii?Q?I+04SiDpXp/jy0FCaXuxIuBozg3BqcZgU/HL1Gj0pGBveyIiCAIdYL/CUIJ/?=
 =?us-ascii?Q?ZEVVFLnbBN3vRjo8jXtJmPjg4MxnEuyqc3Ts1VGYYlJPE/SqdQozXZt/FMwz?=
 =?us-ascii?Q?q3//JiUSjb+QaSctZKcMfkMEgLjzby6YptzXQvgtYhoh9srIp7yqNkcT+KGI?=
 =?us-ascii?Q?m36RorQ+8zsytVbenU2rKV/EwD8g97yeZOTAqxpIKW393W+NdCNYrs2DzqOC?=
 =?us-ascii?Q?Q9hwzdJELHLgir7EHQ/asMUnM3jBPtCg9SkTeD/gVfdJZzYVLVXKKKfVv88z?=
 =?us-ascii?Q?hR9+y3VK9RUgjDcSD0TCLBIZZURdzxOTLSb19ebKdyQw/JtbuCUX3aa52QDa?=
 =?us-ascii?Q?x3HPqBZZHo89HFllJPBQ5892PjBBjRX/Baw7hGUkrL3fGDFsNqM3mAlT4QFt?=
 =?us-ascii?Q?trQAI9FJmOQ1L+ou4ud31PEHTCsDan5rP96CzGGxks3f2ZnCv+lr3rKSYd5E?=
 =?us-ascii?Q?Lwy70M1GmUc5SN2ke4EvAQRYVd7DjG/cID3AwCpj2KgHowiH02sws6FWyQOs?=
 =?us-ascii?Q?7HfzYaEw2W9JN6LCaLVJmxovFD/Dm3kL6Jo6gjxuVTjgN4iKQ9AcNzHAYf7K?=
 =?us-ascii?Q?24KjNwztqWL8qCuW7xbfZwZzJN2IcD+nwSfColNYkxiCdHPhp/t4lDTbFMUE?=
 =?us-ascii?Q?o3lfy/z6LZDljKdUjAI4yHbp9jJVIxHXkODwHb/3GI/8hxpk3ZHJR7I7TDoC?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692d841a-bdc7-436d-428a-08dc26d25ebd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 05:13:35.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmDEsp8zdBiWC+OKk9LfgiIMCDO1I3OPsLYX4vXuuIquzZBkp3xbhoyNoeE6ns3oBGiu1rJd06aFFao90ZpWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

On Mon, 05 Feb, 2024 18:52:45 -0800 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> On Tue, 06 Feb, 2024 02:49:56 +0000 Joe Damato <jdamato@fastly.com> wrote:
>> Make mlx5 compatible with the newly added netlink queue GET APIs.
>>
>> v1 -> v2:
>>   - Move netlink NULL code to mlx5e_deactivate_channel
>>   - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>>     irq, after netif_napi_add which itself sets the IRQ to -1.
>>   - Fix white space where IRQ is stored in mlx5e_open_channel

Also, the changelog should not be part of the commit description since
it will not make much sense once the final version is accepted. You can
either manually paste the changelog in a section of the patch that will
not be applied by git or use git notes to annotate the changelog.

    * https://git-scm.com/docs/git-notes
    * https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.txt---notesltrefgt

>>
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> ---

--
Thanks,

Rahul Rameshbabu

