Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8360B631
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiJXSug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiJXSuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:50:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA8DE96
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 10:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv+NIK/+N3e79/J3+Xo/rCePBbpFCh8JDkspDoda6B1IAGwGGA6Y71eCErh+wqy5OQEj2pvXB27vRFphZFp+SD+yOK9xLIog71a8vK2ryVSebtE3oGjv+ZUpSWXrnlSI8AjKYlkYqNptTbcj6BN+DxmHpn16flsSJVotj2/bpOnohqj+a0ySykddg4hmc295zAOm35WfSXDyj5UutBJ/gxSig3f3GzWZ93Y/lPC9fCdP2w4RqmyN8pYgulg0BGubSFXLVtDjBcsEolFSDQit2F9Jm63PkUpFT1tSm5A3evlVcgecJb97R6NMq+WjyTUbdIo/18wvR0Y0KVuFWGSxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrG26JelutAn9qBe4JL5Q7YxN0VA9rgry8q6x8Y4pt8=;
 b=GS6eVaRZ7Ynj7QM4Qp4XafB6MOxwrDJGNxQFak2yt7cP99nSBZNX5cWwkZyiwYWWHjw0Ofi00891mHh5SsIY1hpsl3P1RgA1sizhoC8TvD4e0buw7Tl/Uu8VciHwnX8XY8L1hwdQxCgexnGGFVOEAAxmeK0/61fpfLd25X01A2OGkO4byvqCKujd8jvn6dKbK3hVcl/eds5drU/Sds4mPuWEwwzlovqM79RqkFdf5B7sCnnXol6sCvJm93PD3AWlt4ivdYGjvL9lm74nSTR7LW7LlLfUUqwRchNkROz1XG0QeIsbgopH+j1+ButJZAmmPlDGq7VqMCEJ9tdN8HbU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrG26JelutAn9qBe4JL5Q7YxN0VA9rgry8q6x8Y4pt8=;
 b=rjEAGmS4sD0MrbgYN4XKZD0oXgCKel/Z/n5wOjPKxWE49g9x0/iLzpwk6PNIvyaz/gJdKNRyU4Aa2Fa6H01IaJ1Vd7NsE/vxKlq5hO9xB9vXA59Jaa8pKUwzHml7MrRZi8HY1nzjDVVHd4ufvZcO8cLcluNLFLJP2UXayfQTOvBfiPEiI0SaZRA0qiUaRUQNwCIB9k0j2UB7zW+PEZpX+jXTPNeA+a3E0u3LZM4iKI9xdGZezfZf3NsfhLIXcj/D9gIsqZQcWPJAhvjo3vA0FcNvNRLp+xz8M3ahZT2rGRg78YgDshSR2ekRYUu1PmlyqUcvLz1kEHvHRc8ACcMlyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 17:02:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:02:21 +0000
Date:   Mon, 24 Oct 2022 14:02:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Message-ID: <Y1bFG/OM5zSOoWcr@nvidia.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
 <Yy4xrlC2lt156nsV@nvidia.com>
 <6a04efb6-84e5-c7b7-25f1-843fa8122875@fujitsu.com>
 <Y0mHslo8ytQNnJ87@nvidia.com>
 <ae0ec888-a509-5e79-2449-69a379d6dc16@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae0ec888-a509-5e79-2449-69a379d6dc16@fujitsu.com>
X-ClientProxiedBy: MN2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:208:23c::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cbd40b-85fe-4dde-2b44-08dab5e183fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXaWnVAJk6IA5HGc5BkcZ/qxVPQx1Dmz8wPJ681b4M8g3FjHFoGXNcMM6Th46kndUpdDaQiddyYOMpeslARCO5SouUrZ25gtBDTYxFnQwErQMGbx9K5HJAT4gptzcabL7Oxcdu961hxBnguz34WAQiKCoe6CsqhFAOOLbA+7WlwGZoiYIzlthPEFHyjWuVkj5TDRGkEsJnYy9M/or3u8coiOEuZxLoljsv/iwMiR5XcWZXhZSRhFgruuhe1hUb+kXgKv1e5jMDevU9b7RLFxQ/C7bvjJSrkZgAN2++Kfjbbq1j/wDZcQDpPFhhruWyuIfJ/vnZedrLd2k2OT/v+n9As3V240SypRkanJ9qbarrBHpqUUdl8QNFR9Y0jYQM/I+0LBBDOBPGMxrdSyHIjknGoaPztq4DpRIRvktEAWuK8m0Vc2pU4BuDHU1SImA0BRLVd7TPtgi3nldOxLEydP6YMnDVDqVRpu2L5p+HR/AhC2OnC5PwJP4o0PKYnknhrHsTuaTmvhXru4aelvY77Tgyym0uMd1LlijZnoxcsfze5LttogTwzsr1D9/T2Zl0XvSv5LN49+5AI/vVJG6adHIlOGJyNE15kuEcCwI7JQXbiwEoQSZVetSHeFn2HpjiJg5jYcqeyIQ1XkQI+1cGDu0bPmSW3qmiWdUZRnnQFNnIP/xuqAPooYqsG5wGXD+kZxSrfeOo1HeYcXkvCRZpMbsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(6512007)(36756003)(86362001)(2906002)(38100700002)(186003)(83380400001)(2616005)(4326008)(6486002)(53546011)(26005)(66946007)(8676002)(6506007)(316002)(6916009)(66476007)(66556008)(5660300002)(54906003)(478600001)(4744005)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTk4K3hCZnVSN2x4RXBhckZ0YjIrb1hhelBCMFJOeVdZYXdZWnY4T283VVdR?=
 =?utf-8?B?TDJlcjZLT1N1am1qZWFoNUFmZllQeW9jQkpzTXJPdlRBTWFmOHRUSm9YaG1X?=
 =?utf-8?B?REhNdHg5dEZOVWlmQWJFUGdmUWFoTDhqQmJoQVdXWWdsVVRHcCtvY3NTbkEz?=
 =?utf-8?B?dHV3VTJiMTVOanUvQ2dabWFhc2ZpZ2diWkxXWWc1YlpSQk0vNW8xWitpazBI?=
 =?utf-8?B?M3Q0K3dYRmE3SCtyRSsyMk9pZ3R6My9xMU9ad3ljbXJFT2I3U2tHSWtUeEQ4?=
 =?utf-8?B?bUFaSFRJalU4WnVidTRENlhGWFlma2xtZFY1d3E4M285NmRLYjJIWWJtS2NM?=
 =?utf-8?B?VmNvSUN4M3lMYnVhS3pTMjRUVWZyRFlNL2VDTktvcVFFbzJLZkFIZkhWZThP?=
 =?utf-8?B?ZkFnTDhUUHp3MG9VZlZoajdxOFJVQjJRSjltYTJqOGZHa0p1TzhFNElIUXNC?=
 =?utf-8?B?OThzRi93Y3hXWVc0am5zWC9XQVhaMUtmbVBCSUxLcjNicGsyTXRxcFlmaEJG?=
 =?utf-8?B?K2xvM3dtNXpjTzZLZ1A1UVA3aVE3TlVjODQwcE5vZnhaSGlwVGljY3ZVQXdQ?=
 =?utf-8?B?eTloblVwOG5ac3pPYXI0a0I5aXp1WFJ0VkRnZUFQWXBmVHVBUE5pczZORCtF?=
 =?utf-8?B?RDNrUXpPek1mYlpOcEp5NXc0enNQMUU2QkZyci9QOTNYUGRNeG45MHpmQWhQ?=
 =?utf-8?B?dkpraEFXaUhWNko0a2FDaUNCR1NEZzBoSGVkU1hCWVBCazZ1YU1hSzRqMXZo?=
 =?utf-8?B?TWpLUko4ei9ZUU8yUFZVQ3gyeThsZzRvV0RJZXB4T1lTTmFZZ1MzM0dFQS9H?=
 =?utf-8?B?VWo5NXY2REo1ZG9wVzBUc2p3cVEzTE9ESWF6cVVPVFo0N3M5ZjhrSmY0dm9D?=
 =?utf-8?B?M2tvdncxbHRpdjhGRDZnZjJCQklYekRvcjhmUkZVSXJiWVJWdFYwenBjU3Vz?=
 =?utf-8?B?eDhVejVLOU50Y3ZnVURCeFlGRGk5R21Od2NUYkUxZFI0VmYxcHhCZWVxRVA5?=
 =?utf-8?B?UG5JWVlINUNjRWYrbHpkLzlNMUFxSUVtOXhHYnQzMHVTQUNJSFA4blBuOTMr?=
 =?utf-8?B?aEZpcG1CdEQ2Q3NMcVpUR3JDWTZ5bGd1akNqMitXTlNNN3hjYUl1WW5EanpZ?=
 =?utf-8?B?RE0vbVdVbU5tLzR2UFp4b1pIS0tmUU8vOURIUi9SVzJURHpoV2FtVnhBbWJz?=
 =?utf-8?B?UmEwakl5eG10VWZMaFQ4Y1E2MytReWowWlpyU3B4aW5MZ0ZXazAxWHRod2Nv?=
 =?utf-8?B?NVNlTFZBSkhZN1BpREQxSk1kWm9YMStEMGdIZUI2VFBaZCsycjYzckpUUENh?=
 =?utf-8?B?UnFTQmdaWjNIZW9wTFFPYS90WCtFa3NTU3hzdjBNUk9oekhkemdhNThEVURD?=
 =?utf-8?B?R2xiY1pub1RtODg3WDM4cVFVTlR1OHlVdGlXS3d5ZFJaa1Qwb3JFdkttTjFk?=
 =?utf-8?B?YVRta1RFbVZyRnp0cHFhTlpQbGhDUlRkbVBwY2ZsLzc0K01lRnlTUnEzVVdp?=
 =?utf-8?B?R0dwSDh0OCtHeDdlMG1qdFBjR2sxdDhuU0tGUHYvRmNRVzk0a3lyUU90Zys3?=
 =?utf-8?B?NFZ3cVdHcGhnb2ZPdXRVY2dGVWhaZytYUGZYOENibE5aTkxBVFh6OEtRVUV0?=
 =?utf-8?B?QVRaSWQ5eld0MW9ZNlBMWW0vZTV3eEpKUkNYZ3VTamVFK0dTRGI3RjFMNjYv?=
 =?utf-8?B?QmVKL2hRbUtzYSszakJ6VHNFWmIzSThnVUZJbnZxT3h3WlNjVXZiaDE0eDN2?=
 =?utf-8?B?akl0a0dUOG1WbkxKY1RmSkU0ZHNPNFlvNys1TWdLUDhlN3lkYzlJcVBMS3hV?=
 =?utf-8?B?a1JyYXZLUmptd0t2SENsOHNXVnJPaWRsYnBRTzZTLzZaZU1kY3J6NmRGSkVP?=
 =?utf-8?B?Y1JSNEEzYkhpb0RQaDVmVmtod1lhakRZTWoyT0R5K3RNSDY1WGRRZDQ3Rm5F?=
 =?utf-8?B?WG9tUWdSWHdwRENvcmpQdGMyVTBFaVMvVmJGQ2xpL3RYcEhKQ2NESm9XWFNK?=
 =?utf-8?B?R0Q4LzNURDdDRVlJd3p2ODV1U3g3Tyt2SXNra25ieDk4bWs3WmxlWDRTVFRR?=
 =?utf-8?B?SlJURlJKdjlGZDhDcks3OVlta1RuMWtlUlFLT0pkcXEycVV5S0FhMzhRTDVk?=
 =?utf-8?Q?QKCI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cbd40b-85fe-4dde-2b44-08dab5e183fb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:02:21.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Liz289NnOi3ZUJ3Shw0D0EojbWJWTP1dmkh4fK3PQ+FIa7ve3Za1xFqZQKiN5rk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 20, 2022 at 09:25:46PM +0800, Yang, Xiao/杨 晓 wrote:
> On 2022/10/15 0:00, Jason Gunthorpe wrote:
> > People have been thinking of new uses for kmap, rxe still should be
> > calling it.
> 
> Hi Jason,
> 
> Thanks a lot for your reply.
> Could you tell me what is the new usage about kmap()?

New in-kernel memory protection schemes
 
> > The above just explains why it doesn't fail today, it doesn't excuse
> > the wrong usage.
> 
> I wonder why we need to use kmap() in this case?
> I'm sorry to ask the stupid question.

It is the defined API to convert a struct page into an address the CPU
can access.

Jason
