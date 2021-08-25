Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865AE3F7BCD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhHYRzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:55:50 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:29793
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231962AbhHYRzt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:55:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSh/dkXBwgA6dd+51xQkTV+SNI+RRHyFFmywpiEAMJwWX3N8K1eOUEd7mX5L7D0yvpFs4M0PTV3gIRd1Up5PwbGRlOA8pA5DiVbQd8BNVvOUD3QZ2SnmAF9EF7SUXdxE0wV6kwxJTTgzir2r/J+TSOjxMX8Kzs0sbxrNhBY3wooHqzx5zn8e/yuzEQZGsjpVPa1Mj308aOyGlsZ4i6SXiEdVftbHtyfwEjzGT0SthjAFlMacXKYySMJNga/PnSn2n15THOpxDSQvopXrt5sr3Xn1/S2qnxd3ePhnCHAvCNOKdTBG4o/yvp4QmLpuvLT1Flu0/U8ZOJu2R12MT7dQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05G6t89M7rkpUGglHdTRMwP2FNjlpXGNK8DYQYEmPew=;
 b=fy0pndyyTj7nv4z3gkfy24ticxfkixZXK6+i+fJwGB8/EQyVBnMwhr1aSO02E47UVJPWcgCdALa/dQ338O5YZ5KfJOg2LPiAGXyY0eIIvcxwTp+IU5UiU0+S0dD/7wx2Qb2UlIHIT6TMs7q/Ferzg5O+Vvwo3l6mr0brioiHwcPozRv+/rpGkhzKfvmbTHLLidT6nuUDatNfbBz7i9dDz1M4kxkjpKfkXSai7GW+o8dFk16RdiV6Fg81UBBz9+xOcRf+DRHBUZTva5OETVoktIiY3m/hmbhJX8lqFfAsqUlAGrDI1FjYqQ+laUdodxulWMSbNc7qFo7kPLqnnMzjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05G6t89M7rkpUGglHdTRMwP2FNjlpXGNK8DYQYEmPew=;
 b=CIESgVBMcU81JhzjnkWNFkBd5RnLrkBX51XaN8ybNQsv87EBrWf/f9+Wo+6lHI9BvvdHvGjgyqPEebWuFqTB93ngQq25CM4xXZWtHC82oDxR64E+9+Rl3Z2Wg3OoUsaTovTbIGw9UdS2BcYQ29KemouR6rfzp0l3BS04vfiSyrwWVdbXrNXSZQ2QlnJzBoGfi7F+TJxeZsGz7FP8Ne3+2k11TITW1sxswPlAIG3xYiYxTPqaLlLJejx+iqtMTFaPF9e7XjBzTa13kXJZ+b0xqKLtR0v0fsr4YueHfgd6T5hpvEOU1215l1Ox18xwkEVugV44HotAZMW+qHdjjUaiZw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:54:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:54:57 +0000
Date:   Wed, 25 Aug 2021 14:49:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Message-ID: <20210825174956.GA1200145@nvidia.com>
References: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 17:54:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIx2C-0052Ft-2H; Wed, 25 Aug 2021 14:49:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d797c6-516c-421e-c7f5-08d967f17350
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51112A0B2DFCEBE026179D22C2C69@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0bDVOSQMHrzOBZobGks7/BvlmNeKbnshBB+Y1XE+pqR4TwiXqwrHT7A+FCXdMVeTCGNo8xX3Uz5kKIEBiGs+Dxb4tseD4q8p4twIN5Hj7Xb5uc3ZUljPSjcCX7wDX59fl0GL+UxjVUqgWfRKIs85i6R86TfgCxxOwdv/98yXdYq8DFk8z76IQBrcCxUAqoQicfo60HpdQ400+Oo0YgaBkXB1p56g0R+IkTE/Zfj+Rq0HjOu05H/8U2x2eL1pcDPOOmAVs5O8efmP/S57o+3gM9N8ZyEIg0FdJjxKpCBAuCNbqtC/iVF4uUU7YZ06luU2GLw3VatUpLNEVjg9i8N9YbhG8L+7lP0WiBdBh2SCgTS2X8U7gI94clkOpNG41HAZwlKhTkRU5xPd09s5h95T+YYcg3lUj6hflZiqrx+TiC6d0LtIG9PnkA9JwHfLjQV94/RCEVz+6g7Wt3VN/ePvelSVSpsn/chdedrvvGLARh44o3UWRdIbn21atHAHgMICkKn7w6qbCozoSsbYTFCygSr6WxXVDmRYGddEGRTV5lGoftgXY7fpgrbGGmILVHXBeEHzN8tt8pxDkoQna68mfznsSaoxpDjr2SyoTJsoEtR0DlyxBBPW+hyUkO+OmIeDOh1ZbxD2GTHzhXA3bp+bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(1076003)(6916009)(8676002)(2906002)(2616005)(66556008)(9746002)(9786002)(54906003)(5660300002)(66476007)(8936002)(38100700002)(33656002)(36756003)(86362001)(66946007)(186003)(66574015)(83380400001)(426003)(26005)(508600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNCTytkYm1HNHVua3E5NDR2TzIyRWtXU1BsbHNtcm0vMEhPWTZ0MUtuZDlI?=
 =?utf-8?B?eU9zRHNTYkEzN1QrSHF5RTV6MTdjQmJvdCtqNW02RzFZbitXdk5UMG5KNmVu?=
 =?utf-8?B?Wm9YMDRNVE00ZXl3aUV3R3NaZVNnR3VvU3o2L0pSUG04SmdVb2FDdlVxL05R?=
 =?utf-8?B?Kzh2aGJhRGdrQXpBbXdRWUdvNFZBOWszaWp0UU9jaFBQZUlvQzZGcFNRL2gz?=
 =?utf-8?B?ZnRNVjlmcVh2V0w3MGc1TGQyaVBiWFNoMk8xckxqTWZrNVAvbjViUFhwOFFj?=
 =?utf-8?B?d3F0enVxM2pyVklRRGJBMWIvamRqSTJZb3BOaGhNbzUyOEhFMVpTc1phMms5?=
 =?utf-8?B?dk12NHJ2d1FFaGI5dm9yK2hCaGxTZHRqR25ndFlzVml6bXF0NWduSk50eGc2?=
 =?utf-8?B?TzVnRTUraXEvc0RWcGViMVRvVDdHdnNsQmU3Szczd1RtWTAySkRtTnZ2SkFQ?=
 =?utf-8?B?cW90S3dZaFZDVENBN1ppYUpKMXJZTmJOMlEwQU1YV3g5NnhhQnhIUlFYSjYx?=
 =?utf-8?B?MUU0Y0tBOUo2dlgyQ28vcWVtYm5nTXZaeFdQSHFHWGtDLzhGT2RyamRmNWh1?=
 =?utf-8?B?ajQzVFhmY1BDVDBONzhwc003NGQ4d0hxYlRaSGpCUWt4Zk1OVGZ3QVNEWjJR?=
 =?utf-8?B?UENuRHBYTTVSS1lPcXE4WmRtYnNIVmJRamkwL3dKQ3hTTnNHMjJqdzlkd3RP?=
 =?utf-8?B?MnBIMkhOMTFCN01uUFFZblMyQkZpdUFpZEJHTWRlT3Jrb0w0SjMzbWlqUEVv?=
 =?utf-8?B?SmhBaUpDejNMaEMvNnpBV2ZkTWE3dFJBMytRUjdGVGJrTTdKR2E2YzZKQXR0?=
 =?utf-8?B?R0hHb0hyaWpIQ1dBSThDUms5U2g3cHZhaWtyVmt3a00yRlpMZ2JGb0x3RGlu?=
 =?utf-8?B?RXNRdFVzc3h0bmxJdGhHQWh6blRtVG96ZUdhR3dvenAwTEdtdlNFM3BIVG5k?=
 =?utf-8?B?SVR4K3FieFErZHZqY1JHWU5WaFN5dmIvUk9qVXkySEVrTFAwbHF1TzM3YjRK?=
 =?utf-8?B?d2tqYVBoVzluSncyTFlVRXRENzE2bHh6eXhuY0lObkc1YXA4akV0aEw1NEpN?=
 =?utf-8?B?TUJJTDkvMlZWcStydEVWOFpqZ3FrQVJ6L0dLanMvNVREdjdBNjRFQTJGRVp6?=
 =?utf-8?B?QzlrYjVwcE0rQ253d1hVNHZTQ0krcmROOW9LMy9xVFQvdmJoUlhaZ1JFSm5P?=
 =?utf-8?B?OTVCY0NoMW9hdit6UUxsV0ZMOVVmWWhmTUk3Tk9MY0JPR2VNSldrVXRtSHlj?=
 =?utf-8?B?LzkyWE03NnowUE1Kbm4zdFBqRTcvc2tGa3JlUmhjczlkcFFZVkNKUWVYVjNE?=
 =?utf-8?B?VUNzeTU1QlVWSEVpSlA2WlQvVC83MzVwZXZRSmhxa3ZUcmswOWxmT1k4SnEv?=
 =?utf-8?B?VWZLemtuOWtzd2kyT3JmL0xQSDg5VFFXUENLSUF6YVQ2N0VVemxITW91ZjM5?=
 =?utf-8?B?K2pRTnZNMW5pSDBDQ1ZjVmk3TUFnM2FJaEczU2JOTWxUUjhsbXlCQ0swVmNu?=
 =?utf-8?B?Sy9Zeis0WTZpMnY2TTZtcllGOVRxYkRxaHhzQkhSU1BTU1ZGZFhCN3Z6cVJt?=
 =?utf-8?B?c01rKy9NSXdMc0dxSS81ZVRJNHJhalVOVEFCd2wydWxuck1HaERXSFVQZ1da?=
 =?utf-8?B?NDB0T1NYOElXdTg4YlJnemhEZzVZQmZLVUphV2tYZ2hmZjNTYUpESHAvVlBD?=
 =?utf-8?B?K0ZCUVZJQm9Ibk12cHRoNVJyZUdQeEJrK1JJc0N0VU5LT0tPRG1xcUlDdEV1?=
 =?utf-8?Q?XAP1Hdse1VTh9t8jg5hz9ItxrFiITJMnlgpabRk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d797c6-516c-421e-c7f5-08d967f17350
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:54:57.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSQE79W3F+E5c3gDkkqph0z2ChWp4go3kxYk6MgeIc8HeEqnK/p0wsNAdFya+NwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 12, 2021 at 06:12:35PM +0200, Håkon Bugge wrote:
> A MAD packet is sent as an unreliable datagram (UD). SA requests are
> sent as MAD packets. As such, SA requests or responses may be silently
> dropped.
> 
> IB Core's MAD layer has a timeout and retry mechanism, which amongst
> other, is used by RDMA CM. But it is not used by SA queries. The lack
> of retries of SA queries leads to long specified timeout, and error
> being returned in case of packet loss. The ULP or user-land process
> has to perform the retry.
> 
> Fix this by taking advantage of the MAD layer's retry mechanism.
> 
> First, a check against a zero timeout is added in
> rdma_resolve_route(). In send_mad(), we set the MAD layer timeout to
> one tenth of the specified timeout and the number of retries to
> 10. The special case when timeout is less than 10 is handled.
> 
> With this fix:
> 
>  # ucmatose -c 1000 -S 1024 -C 1
> 
> runs stable on an Infiniband fabric. Without this fix, we see an
> intermittent behavior and it errors out with:
> 
> cmatose: event: RDMA_CM_EVENT_ROUTE_ERROR, error: -110
> 
> (110 is ETIMEDOUT)
> 
> Fixes: f75b7a529494 ("[PATCH] IB: Add automatic retries to MAD layer")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c      | 3 +++
>  drivers/infiniband/core/sa_query.c | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

I'm nervous about this, mostly because the mad layer is very
complicated, but it does seem aligned with the spec.

However, it seems quite wrong that the timeout comes in from outside,
the SA timeout should be integral to the SA layer..

Anyhow, applied to for-next

Jason
