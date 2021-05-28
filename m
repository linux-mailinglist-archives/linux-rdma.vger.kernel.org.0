Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1069B394926
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE1Xgp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:36:45 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:58177
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1Xgo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTCFla+D2+WlCy1XNKg9n6PYXLwXwxmpeIWZou9EZajKqJy+6IpuYW0hj45G+d7fTsSQw3qtE6Y+GlcsAS/b9nC6m+pHyE5R4HOmz+pqYhzMBvrKYv8GAMr6YImTduDkJXrg1Zrs9yp0VJljcH9o0D46w7LNQD45eJGCPRAZNflhqKWIuRRF17PZrzvlYYcXdCo2YwhjKRXB5yclvMUso1Ek3HD25DDANy/JTIHmhJY6+VGTy00JdLkItUTgJu+pO5LCV1jELUsQOon6ikZWyD4Eb3HWPuJYCfoCuftuSSinxm7tdZ6t1DMLvv6w7rePDRVQpMSnsWCSOkhBbjWvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUqQm9uY/bUZlTVVxkBn11tvoJna0Cj0pWHCPWtnEzA=;
 b=nfUyPxX2UgOevAlaYtgfDgeJslvlYnF9VKS0rFPETxnP6PyQ0V5hjtojOcJkOjJIQJ+W2vmX9GAYF+uHcisqB8ulNEgWu3RUPFhOqHqa+BXleZBFqLLaqkmU17WLUFbU1VTRHdZcIWP3g3Swwpwtb87U/fp2EKTU2BT+vHvzJ7KkidXI4UEFvUVIHdhQ7oLoUJxdqnLIg1y7vGBU5hpbMPtgWx6zeh3nPGGja8PyXUPRdemXAslYlftEENmthN0tgOujH3aBvgjYERhkfzzHntSytmCcdcgTSK6xGCY8zpOhXv+0wfiawLbmDeAiBU63kUd94JiS5J5wfHmeLrT9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUqQm9uY/bUZlTVVxkBn11tvoJna0Cj0pWHCPWtnEzA=;
 b=oLnR61pra+/ImK94xrEUOlFN/Xy5Avb1OEO88o132lFtJtG5u5HHNR45r9ZDcJjqVhpGnv2JXmh+AlADNsXpRBKe+qrwT9VqME/zL8suedPniAMitfchqQXlcl0NbCnFsS8AS0MQDAImh7RCHXTQZLCNnqCHk+YpA/6idXI24r8v6Nbqoy+kfHv/nCXQ/4sMFx0/NF4G21j5WTWjcgsyo+lrOmlqW3XhuHLmeD5HidRryIY9opHTzUI2lLUY98p+fO9CN1H+DeIWZUJ2dvgdNIbi/bchQWSF9t55018Nqw0s/DGcOM4ni3UUg2xgRUhsGNyWYHOj73I+/pvjWMr+AQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:35:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:35:08 +0000
Date:   Fri, 28 May 2021 20:35:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3] IB/core: Only update PKEY and GID caches on
 respective events
Message-ID: <20210528233507.GC3862344@nvidia.com>
References: <1621964949-28484-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621964949-28484-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:35:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmm0R-00GCp8-Ef; Fri, 28 May 2021 20:35:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba812577-29b5-4de2-8409-08d922313abb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB515970A188828A5863D29BEAC2229@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWIEGD/bKzCEhaJ+qo1DjwwfbwQ/nzvxkk1+ArlUI7K885M9ZGWcmB3gpLBABu0/f88VwLsVR3V7mEBCuLsncdoA5gn7F0QlAUebXYyUAkpRY6tT4uFGJFrXUZRk74pm1r5PHRPxgjqBFd432kHlkifj1M95QuNwjrxaAav6ryxypf8eRf/9QW3mvrRIGRNisTy7iXvRDn+75EBR6buN2R2FMuDGi11c52SR4P5xDzyschFWE7ED3wCJuxcifnco+EypTmbCH0Bif+2fBa2fd6FtkJ7N0VeM4NyVpI0oDmxozSNZebaQm57HWPhd5cs8bE/GUcuXyhsR0XpBqM1TDcTuYvru9kWHGbKrJsDOaEsQYfbZsGPseGO1RjLt38lQUZeGhwvVKJJYbFsJSXPXf8e1CPthBcSzUgHEBSJQ43UhJ1VUh58ZBSNE8SsPoe6lC3IE5gah+tsxkf5CoxBlOYzwcV1dHvyB5Q1uKpKo+5laXDnCLeLiTVFwa9tvcj2/AXDUdMO4bQAQeF8/oQD/8NRn/m0G9BaxX4YmqalyLXvXRalHdEHy6kUMtCBsG15oRslNHwT0mjI2DyXETHsl9OHrldsu7OIhKbZGL2BI9MM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(66574015)(86362001)(83380400001)(8676002)(6916009)(316002)(2616005)(186003)(2906002)(426003)(1076003)(66556008)(66476007)(66946007)(26005)(5660300002)(33656002)(38100700002)(9786002)(9746002)(54906003)(478600001)(4326008)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REJZMlh1TFRlUlRaV2JzbE0yR2FnbTVSQ3FSbFExR2I1SWtwMDRRRkQ5WUht?=
 =?utf-8?B?VE02RnZCQ0RMR0JCL0xheDR1WTAyNUQ4ZGtsaFFGTXF6Nkl1Zys2cHZpZnpu?=
 =?utf-8?B?Sm9PVDBMdnZnUmtIKzlQWmtFZEc1dytic0ZZVEZOVUtMUUJOVzdLZWR5RGlu?=
 =?utf-8?B?aERuUFNzQXZQQ3VhUm43cUhSS3BYZzUxSzl0YytuVFZHR1hTVjl2MDJUM3dk?=
 =?utf-8?B?dUVUYU5WUXBWLzhuRExGQ2g4N1ZvN0tIRldLR01WSzk5eEEra3RzTVkybDhP?=
 =?utf-8?B?WlhtME9lT2Rxc1FQcnpWQ2k4aE9YV3dwTFQ4Vnlrc1pKWnJTanc4ZjNTOTk3?=
 =?utf-8?B?aVR3OVRNd1l5ck5relRmelhQT3hxN1RFcDJPQlYycGppZVVBOTV2NFdIQ1Q4?=
 =?utf-8?B?bktieHJ0dit2aG5yenZCS1dzc0VKR3kxTUpTOHBBaEVpcUpDcUhmK0J1b1Ny?=
 =?utf-8?B?VmFGTGhicnRFcTJlT3Vra3h4R3liRWNjNkdCN3k3MzF3K3dDemNmN2VYMkNy?=
 =?utf-8?B?Qmk1RmY0d01PalIvMUczZFQ0dEQrRGk5MjJvK2V5eWlYdTduVGtYeW1QSVNM?=
 =?utf-8?B?dUtWS2tuQ2dKWkIwbFZ4MDl1Y1JCSGFQbWNQYUxZNm1ZWjAyNFhXM3lxZUdC?=
 =?utf-8?B?T29qQzU3U2FrQUVNVDdua0hiK2RLRlVuaWdXa3lFNHpTelhGL2Z0SzFzNlh6?=
 =?utf-8?B?Umd5Q2tDMGI5OUhRVjJSdmVPVzdFRUpUaGtNbFZNc2VIM2UwWFhRYkdyMm9K?=
 =?utf-8?B?a05XcjhhOHloVis0bk1DNFp2OU41Vkh5dkNFZ1Z0aWRadld5VVZ1NnpUN1JE?=
 =?utf-8?B?eWZIWnM1aDhmbWlqRWZGMEgvZWpiYkRkM0FlaEtETDZEckUxNy9HandBSTVV?=
 =?utf-8?B?NWJqQ2dhbFlRK3IrZ0puVlY4OWx4TUN0NDNHTGxvMDdKeXUwbGloSHlLN2Vr?=
 =?utf-8?B?WmFSaXhkWjl4WlR2OG5CWmNmUVdtT3hHVDZJS0FVTjdlTWRZUEdWNC94bGo5?=
 =?utf-8?B?d2dyOUZxbEg2dE9PSW9USGxPcUZoVkZhamVXUTFNaHk3eFRTTzJFVUhVTUlZ?=
 =?utf-8?B?MTArbjVPdlpKK0xwTFdHb3cvT0d0WDFKOXFwcTMwdU9hbFJ3dFhxemRtanZS?=
 =?utf-8?B?UGJOOWNGSk1HTGhOYTh3TmY2UzNJckEvQmY0OVYrNVcxYlJRMVBDYmthK3Ar?=
 =?utf-8?B?MDJBdXIxcHVDYUZNZTJqK1N4Qk5neTV1dVU5SVNuK0liYkppdnhKaWVmdjR6?=
 =?utf-8?B?dXgybVVaUWhsMUdWUEM0MFU5Q3ZyZGs3QUJ4TWd0LytpRVFHK0M2MU1FOU94?=
 =?utf-8?B?d3NONkx4a052UkkvaDRPRUR0dzVjMzBmdlhSbWRMb0tNbk56a1JCNElHT0lQ?=
 =?utf-8?B?SDJQV1lrVVBzM1RaUlE4eXlQUTlkMitpeDVPS0Fhcld3eDJEMGJmMFdKRlhX?=
 =?utf-8?B?UjZ5a3ZreU9lUUhUMHVjeXVJY1ZiOUhTeG5RN1NaK254V1haakp6TWYxMUxp?=
 =?utf-8?B?aGhEbEEraGxENGpwcXQ3WGRaVm1WTkVsNWkyeWdWWlJ4bGVab0RsNkcyVDBi?=
 =?utf-8?B?bEE3YUVmK2I4b1JvYVo4clhLWmcxQnN6dTZzVkVJMlo0ZU9ZNGhuVVZXUkFH?=
 =?utf-8?B?UGtLUVRWYTd6THNiekVIcS8wcHJyZ1RuRTVOTjdsVWdjcVJvZXJOeFlxbHdL?=
 =?utf-8?B?M3l6TzhQeDZ2SzF1c0kxMmJDZU9PZzRPQWo3OFJvZXhJVmMwbnpuTEtqWjhp?=
 =?utf-8?Q?njGot2b0g/SB4Vr9tSWOHujvXNG8pjmUfkmTKai?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba812577-29b5-4de2-8409-08d922313abb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:35:08.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIJa9FXjNBaiYhu1O4YyZlhuyCEmo93Ltgafao9GpwGeDO5RWeBtfJQRKzUc0Pd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 07:49:09PM +0200, Håkon Bugge wrote:
> Both the PKEY and GID tables in an HCA can hold in the order of
> hundreds entries. Reading them are expensive. Partly because the API
> for retrieving them only returns a single entry at a time. Further, on
> certain implementations, e.g., CX-3, the VFs are paravirtualized in
> this respect and have to rely on the PF driver to perform the
> read. This again demands VF to PF communication.
> 
> IB Core's cache is refreshed on all events. Hence, filter the refresh
> of the PKEY and GID caches based on the event received being
> IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> 
> v1 -> v2:
>    * Changed signature of ib_cache_update() as per Leon's suggestion
>    * Added Fixes tag as per Zhu Yanjun' suggestion
> 
> v2 -> v3:
>    * Rebased on tip of dledford/wip/jgg-for-next, 331859d320f5
>      ("RDMA/hns: Remove unused CMDQ member")
>    * Added Leon's r-b
> ---
>  drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
