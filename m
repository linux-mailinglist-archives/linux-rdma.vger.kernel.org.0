Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3540C625
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhIONUH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 09:20:07 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:45628
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229670AbhIONUH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 09:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCzsGnBChDtUs1wjyvVRv8hyTddNGY8FB68HQQPL4sO9b8aPDEG9jeoT7iBGsq/IBEn5rhJGEircn7KlnVDVLLVTWxMvuIUXqdyh3rmA9pKps/DyHywoBTzc3FXSy/MVSLj+FIiu2hiNWWt77m4cRFW9gvOs/I6X+PZYejLzF1THD/WPIFIJx1iIjMJFRdTpyCF2cbyadGI2g9HWd4ZPPl/2HC2mwt1fTf7/ao5d3xXSSNxQD618O1VNUteabeabgLqOzeLW+ioRnWnob5S5tstzMQ6bl+l59jY0uN4U7LRAgOLWwIMrfcaCM7BzvxrnYMiG5uF2Vz5W+tbQRpMqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lCtroozUD3OgHTEfFwWxXa3n9EcVO/nMjReXgjt4LIM=;
 b=FmFjx9rCIRyHnEv9NBVbnI+ZUyCmgEwl+MwqVxNzgIq6ByMjtDXMUE5IpHup22Svv0nWEnx92gA65AqR95De+Cue9ilgsCo2K/pH2plx2BgTBTk+PgUjVt9/0dy2cvL4dqz/W/RGP7OabmhwKkIfkMY0MjQRk3AgEYhEoU7TqpXGcLNYYr5n4GNIBGvCr0vnMElY3J5lvbia2f7goPGHmd6Su5TTpDxKneN48eP4GRn5jqAqATScf/Fh62ohvuqkFP5D1T7zIXqSbTn5dYKh8hTWp/8IW2gG75rlGsT3tAV7bJ1hmRwyxR6q9U2DCmjj2utPnEpit0c1VgOAHDnUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCtroozUD3OgHTEfFwWxXa3n9EcVO/nMjReXgjt4LIM=;
 b=UeNLLOmXTpHeFASz2BleUx+NpXtsoxDExoM++fz9CHjcJYV10ewcXe7aYTOyTb8k3wZP4qyTPqUpfA2cwy6wI7fRWkQVSIQ+TmDig6YeHbaJI738lza9w4V6OJQ4p1gB/qaWWoXTIDiZariRxL2GXIZObb9ahv+vbmBGxfAZbfTHwXiUiD09J7sAuNl1CGPELuvuB/KugeFYJXcogIChBUE4ldXxQSysjnqESq3FjF0JBSWLwcaugQoQPcOax3uISlXM9620FGN+WvyMvHOUnyFZL92gkzLYDwAItHrDzPEPOMZF7vzZ4JW0kqT52WohxqDhcVCATulBc0pNIDGk7g==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 13:18:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 13:18:47 +0000
Date:   Wed, 15 Sep 2021 10:18:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Tao Liu <thomas.liu@ucloud.cn>, dledford@redhat.com,
        leon@kernel.org, haakon.bugge@oracle.com, shayd@nvidia.com,
        avihaih@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.liu@ucloud.com
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
Message-ID: <20210915131845.GK4065468@nvidia.com>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
 <20210914195444.GA156389@nvidia.com>
 <4b711688-9a82-03f1-844c-cf1557892679@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b711688-9a82-03f1-844c-cf1557892679@nvidia.com>
X-ClientProxiedBy: CH2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:52::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:52::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 13:18:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQUoH-000sVC-QV; Wed, 15 Sep 2021 10:18:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7237844-a4bd-40a7-6658-08d9784b5999
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB520686A55E13370296836A65C2DB9@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MsK1F7mD3clCvFKozRqh23yb+vrHWg240XqHJ+Acf3FxUP/Is6ailHLkfX8iVmmNO3bXt7JLZYXUy44ASluVhprFgc/FkklZNL+mh2KtbQNauYZ9DKqv7HFR6mKzOlRsQd6dhczgLDzo+9Fec9pDQBv0+yMVh9jzAesFZkR4If1z8kKLbGOcrKOi2eCmIj4R/wnEU5H13jqcjFkhFueJKw1MNw1phUCDGK8D4lBACwVqbB/wWzcXhMf86xdU1xdfro+XHce1M190xu3U/xmTiKeAEMmw/9RPZ8ela3cd9EaNZ7JqOZc6F4F+5xpXLW0jybWeKXTuOIbOaLdpOvrtvbaWLDjrwQkUXAi8H0G4XpDIWiMm2bCtaSpkhRYAHfkXJ9/u6DTCTIyDh0YuFDa6EIhTV1IzUPRvGO0xr2uokkCf7Ow7Utjp9SDdc49RBG8XqPZM4HJfwGYeQ/S4pVuwxVf8MbAco1U5fJ5z5M7Idp9OTFYcXrN1uhn1VtwQcYmYe1BaUsS5AronGly5fFG6kbIy9Cx/759ViphvIg24nSKIpyrgHmWMN+b93hJR1rNzVw4r1F4kJO90ibD4dKT7metercT1Y25dekkE4ucd9gQsp/Qq5iILLmjbYaW99xjtoDVL8NF4zq/xr/gwyqgBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(5660300002)(86362001)(33656002)(6862004)(4326008)(8676002)(4744005)(37006003)(66946007)(66556008)(2616005)(66476007)(316002)(38100700002)(26005)(36756003)(508600001)(9746002)(2906002)(9786002)(6636002)(1076003)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzvjPK34iT0a70+vpDtr4DqeSI+3ynqJtVbgz3T0nJdTLpW0R/U/Md8OVIV4?=
 =?us-ascii?Q?QbparT4misaUhcZa17rkvBKIgNnpxHABKRdwpaPFchr1s8wEsfianc6ZD3Oj?=
 =?us-ascii?Q?ffhKkCB/fAGEueCiwNmrhpj0hgToxwHciM0VPPAwQjDX07dUgRX7rDNzhjJp?=
 =?us-ascii?Q?LQyfCRvB8xg14JWa4qxcUZ+o1ZAo2r1/7I9JyjP64xGR/z1DaPV4wRFAuWCI?=
 =?us-ascii?Q?LakAIVF30DMdPpQEpynlr2WSuZXbKxlsU8qZxLWe6PsESZAC9UR8x4Ru8v4q?=
 =?us-ascii?Q?jwlWERbvu/P55QrnBd+Lj6Y/7QezVUgtf/goj63HyR9p951n3vynZ65SEPKm?=
 =?us-ascii?Q?+BOcx3itziqAbPoUMa6dMekOACbo2kfA78DS+8a5rIofBy6FM++Om2BlC8k8?=
 =?us-ascii?Q?kqUUBa7SZXH2SHvwrqMRYsdlfVMiA+Avxt3P2Lycy0BAX080ryhdlTvzZQuX?=
 =?us-ascii?Q?er0qnzeH6NFr4NM8mxlGt/dWAnpYdNNxur2JGL+9/OgsE9a2MvOWNjnnxhj7?=
 =?us-ascii?Q?Gd0zHaa68sYLH0PQZ3KifikwubTwkSni27Hj4cm8jmqx8X8GP12QLLbiMS6O?=
 =?us-ascii?Q?MkSVYMlYuOsLuzB5J+7M3ZtqBDRC87sSjpwyKCIRu2gMFUtkJG86Ade4xY1a?=
 =?us-ascii?Q?fjWhg8VgD8i8WbIcZ5Td3U9ryTThyd5wqykZqn1fWxfAXyR/t50kwUrbZ62p?=
 =?us-ascii?Q?YWBQQLPoSnYplCtwWK8McBFqq5giGm+7I2ObgB4Yk62xAij2il17zWV4B4YS?=
 =?us-ascii?Q?22R7wDpknbLQqJGsSu3/mTJrobANb9Hq7ieb6P7XxKDSXLQ/53VRBpK1WEBK?=
 =?us-ascii?Q?0x3MKKT+kb79goEHE8JiWmY+WVGvhJAy4qDSF2YYZ1SdWWRFicHQeVmhyTwZ?=
 =?us-ascii?Q?mGZ0Xc4B/IQdoh1DSE/DQTxsanUmGL8UiFXuccFDPgwOLv1+nq761rPI1fGQ?=
 =?us-ascii?Q?F29JP4r34lZBmCMszInFE+sPANKK3fExo8NMthnOwDZfUZGX4RlGGVdOHTOh?=
 =?us-ascii?Q?vaIkgZxA6gKzB0syIvMhoFEq3KHm6WGPPTcI+N42X4flHiEj40sW2haao3uB?=
 =?us-ascii?Q?6Yw0FwB6iKYyRFTODH9UzMIJuwkH1/ZtNKWrl/UgymkXEtW8Bb3R0lTZCWTH?=
 =?us-ascii?Q?JsV5SwAODXdVg3FGndGQ6jmYWAHhntmcLv6K9W7k/7MPet/dJdsYZgEtuDgT?=
 =?us-ascii?Q?d7ZL2GSY91oX+sunmBd1UzgjJ9kAbRbxRGN4hp/FVVB/f1idQ1fnsT655MYr?=
 =?us-ascii?Q?AxI5/xHnr4jIofe7vk84CmOv6Sqaa/x8O4tFhxxjczmLCX8uER1+rfNUj03n?=
 =?us-ascii?Q?GrA4uZ1B1TEdVZNET0tWCd6G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7237844-a4bd-40a7-6658-08d9784b5999
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 13:18:47.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNEoy+8ton74fBqEeVQafDk1WF7tE+T+4yGncTfmA5jI+1UBmB//7YsFPe7b7h43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 02:34:19PM +0800, Mark Zhang wrote:
> > -       case RDMA_CM_LISTEN:
> > -               if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)
> > -                       cma_cancel_listens(id_priv);
> > -               break;
> 
> If this case is removed, is this code path still good?
> 
> cma_add_one/cma_remove_one
>   cma_process_remove
>     cma_send_device_removal_put
>       cma_cancel_operation

Yes, it is complicated, but the cma_process_remove() won't proceed
past cma_dev_put() until all the ULPs have gone through _destroy_id()

So all this does is move the reaping of the listens to the destroy_id
time

Jason
