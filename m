Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEC76A053
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGaSZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGaSZ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:25:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B97EE79
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzdAG76Mba9ToME2/bPLiY128cizCWNY6T88iw38UKbTH4rtdPmL1/GdCDG7EgRoUD0COIFYBNRTSUlBElh4DcDc/SI3D6uJt0dSRhfImShWmGAeZaOYg44BJCzr/uhx8LaIrJsPl8Xsi1YYgFS3m1oBNazYpUi+v5bGFIbM8AWwh+9s/wguDl4ktyIpWxwWIkYmOvthDp1IQqgNu8DuKM9E1R8Jfjeta9gTUaMJLNrI3LN2KvKdWXNZ8X1QLWA8EU4Qt0cSj61Sl4DN0MI21fiw9mgrnz+UR6MGbpx7IyqJJETX3FXc/E5aHG6dl1AuRyRMlHLrlWdoji2oRVo5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HWEhO9lsS72IfV/7JwC6wbMTW2xBQqG/cUy101ARPg=;
 b=dqsBXCejjX+fduzIGyC+xs1eqekmJbRg0d4c3qcvXDN2tPwz6Z0jGv6kN36hDGTEqSTGjhjzxPg3kqDUxpQzYZpd/Go1bw6PcwyWhbJ6V5mauNbQ8+nDCz+GPc2AJFz2Pc5GS7w1uL2wC1HasIyR2pH9cUpD8vQWjqLkIt4ZoiYrBNN0dORy8WEAIWirAhDV7ArxKx9yUQg8LLP4cuBkE2EGw3ATbgDGhy78ImP1yr+CZS9jsf44Sff0dX8OdK+V9jAB0Rg+eiyc12INTX/xB2R8vnbLtlTFKsIqNkqYIxd6TBTH2hlYsWagiN1AWebXVN3oQ8DuIEk7WElmAJQmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HWEhO9lsS72IfV/7JwC6wbMTW2xBQqG/cUy101ARPg=;
 b=dj58RpBzf+jf/GHvTs+NH5aKdFZrSR6GC/jDP3VCj/Kh5AgSvYoyze3pdoyWFFl7lGG7ox1eeG2U0mFFJ7japfjOKEZExuBFUqEziKTwVQPDlQn1SySK0hr3Zeclo1jGCX30GGLHTq8VRPAiFksJ78HcS1j4wmUkvo6jGpiz/v6kT4JL0PJ8kFdDRzyr18b7u78+HRDseseWSuy3Nd/33qz78iiyCTPmp2u0eG/Gt/5QoH/BQidSqiuikyNA93Czt8tmkk8kTB3FidnvHhXwhPRWR9sRZokbJfcAnmQ/RgkX+b6JyknXUtHF3qp9Tayl00cBkzvG5aIoQHW/c4gaAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:25:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:25:26 +0000
Date:   Mon, 31 Jul 2023 15:25:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Subject: Re: [PATCH for-next v2 0/3] RDMA/rxe: Fix error path code in
 rxe_create_qp
Message-ID: <ZMf8k8kx8GOqQeWz@nvidia.com>
References: <20230620135519.9365-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620135519.9365-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c4c5c3-6cb9-4555-7e16-08db91f382eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mX/jFwN6VrSVMEFXUHRJI5fargYPINCnwEto8YgAct0xl3CemgNEc7jE6oRfVFUa6PuhfRs47aqSF4k/s6EKOiAUNyuOrWkSpYJqe4zpY44u+tifLDtUQpTE8WLLQ+1kGDo8aUUBp0ahre2TtunQiBJFY2CYQhlmNggvJrUZgK0FJoAKDbj27Qclmd8A8ykPwEC3EEpQSi78PiOYXOShH6XKto8RxIAJ30jQ5ZoGGM+3gQUXhDqS4+sEhVieWivGDQ/3VkFDlCrPh+XrHBjFlyO30kSd9+GNlNyuWUsBwvD4Ftm2F4uArxW3IYpF0pfQdONsX7dVM0KE/fIKdZz8fwXRmE4Kt2aF88p/odMd+VHf+QNSmXtyepJgA9/MQoKay8jWn5TTOA27f81xInEAhxn76DNk8EWRqf+wD+GshUXS+2E9Sftpz0eBw7QDwV1z7791T4JdHS9DQjHK9sFq1Pma33g0wjxuNMOIXjpxtZGIstSPc10K58VxCTTZde8DMraBVNVT5e9sMa1jXPPAxuCTi2zSFxWSJCsc9Evjsa81LcFeO8jy54fGe4jV2U9NPsPyR/Uas2Haz/NxYaVJnwmrkeNKyqzEhWp6ffiL/hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(8936002)(8676002)(26005)(41300700001)(316002)(6916009)(4326008)(6512007)(966005)(5660300002)(186003)(6506007)(66476007)(6666004)(478600001)(66556008)(66946007)(6486002)(86362001)(2616005)(36756003)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbCz7lG36ZxegCqAm2hvNls5hYnepfogxy5ZYUyJDGULvchfg18NoFxXqqJs?=
 =?us-ascii?Q?OJcNhQ0fCNWuFPQB+54DspOxBGtC/KPyDMkZNJKY9tXnlXZzH02K58ufPR2J?=
 =?us-ascii?Q?+4k6f/a/QQUU757icpl1yjnH+MGOWn62V8JmsqfIKAhz+5gWyQzV51bHBWcA?=
 =?us-ascii?Q?X1Yv/5Tq8pSVVQtby/G0Ha+zNlar/5rT2dSFqgGGsah5felDIFR8cuw/ywHX?=
 =?us-ascii?Q?KZT00DvhlbW3allxQRWUTTZ6qrb3OEtV1ltoB19sJNSVIZ8zOQtbVu6InHeX?=
 =?us-ascii?Q?yDuC3jNhw759P5UdNM19g53zmpjRqcjmZggV4MRMQl74c6YrH70tBikRg2vZ?=
 =?us-ascii?Q?o9Aan10Z8wTujMfbdllJ+iUwGygOKPoYrl50XLnvsBgubjm2jYv1JydWS0nc?=
 =?us-ascii?Q?dsrm9FHrqUxndxn+OR6+i0PrFPBPnp8kyRW3tzVJrnM3eERsgb6WH2k3003C?=
 =?us-ascii?Q?hiLs26i12NPkPeyY8bfJegjsgMrSFEtR4K028XL5KTunhLVWujrrDTcXaC+W?=
 =?us-ascii?Q?SDufBJGAR70DTTzy+gIh3vEHad7oPX7FO4tJZNEvEazHjiFQOVLoGa8K383d?=
 =?us-ascii?Q?9dr9QnwXv+tE62X+nYadoPBejF6x51ma838HHkBx8czLufBqVabqCcDHwLo4?=
 =?us-ascii?Q?oZeXwwEvSgAVDjUogGh2DbdKFzkYXC55ooCMnx23M5j3m+1bOG1CFVSp/kCX?=
 =?us-ascii?Q?2KrphwQFXzaDlrQeBoxb/ag+U41Sy7KjK7lQ1wNUI/oZc2LA/HzpjmOjMXb8?=
 =?us-ascii?Q?RNI+rzVNQS1f3+VzCLKG0E1EZoLyuqHNpbFbLtR0JOl5Lu0BIpOv52W8mtKb?=
 =?us-ascii?Q?y4eacjkYjssGGDy2X2S9aJwMHIpm5wrQjNtnpzSveyAGA/1Kw0xMoXi3wl99?=
 =?us-ascii?Q?/xS5MfbupFT5gQIgSfaz52LuM3JjH9orBS8waeNsMwpFlfatkwWHqxquS0wT?=
 =?us-ascii?Q?Da4LtFr0E4cr54g+WYhP4V+j8JgxRi052iMuMuoyyAMhqaBLM+6/1ffBOgZ5?=
 =?us-ascii?Q?xHgeiWTfF5yGrXWom6ujvKxwzQK/KLiqTHRIRVczU/8D3zIS0sDmDEJMUYlR?=
 =?us-ascii?Q?U6TbZ02yyMiwWsQA2jRFlfM1LgVEnxfkS4M6M5RPYsgMMP7elxgsDFAKZiII?=
 =?us-ascii?Q?KxUHMNx7eq60J7Z9y2PGB6pAuV1wVauszvpRgeqCP5daVd5tg1D5UG37zOGK?=
 =?us-ascii?Q?g308rHlQtZE3eOHaIaa2J4PDwKqvCq3Ka8n7Q6SMpVDdRuNWjZ93kXxTe0sM?=
 =?us-ascii?Q?cTP5slPcjxLLF6gWaxgNJVU+5/Mw4hedw7bvvv7mBJahBHIOlcPjE28Sl2WB?=
 =?us-ascii?Q?z+nKGOlPwdA/GzXlnk9Pw27/JVBO8YwQ8yxo8mCp3uhAMPrUYr3dAlVJ1g/o?=
 =?us-ascii?Q?pPWfhhjtQi1eXXnsHZsVFGO6MyBiFCGX6YKTsqxx/ZVSWf7GSgTeRpmOjlb3?=
 =?us-ascii?Q?sUKRnU4lSS+Kbh49UMAk9/tnhki/fSC8D4BGzvhUSJSvLw7lKlaZWNK3fDxd?=
 =?us-ascii?Q?clSp6l4Aj/ihbDa0Wg8I0FviseF5z1TMzGv6OS9W4Pz4/g9v2fhgO0nuBUf0?=
 =?us-ascii?Q?5N6j9tXBCfATm4zfKtxdv9LdV6CKj30E+xE4qwXM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c4c5c3-6cb9-4555-7e16-08db91f382eb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:25:26.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjZORFhlyrSWgHPtBDy9jvlJoSCoGggVlGzw5esO/gfNa41tWrmRqgfqR2CFYmnW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 20, 2023 at 08:55:17AM -0500, Bob Pearson wrote:
> If a call to rxe_create_qp() fails in rxe_qp_from_init()
> rxe_cleanup(qp) will be called. This code currently does not correctly
> handle cases where not all qp resources are allocated and can seg
> fault as reported below. The first two patches cleanup cases where
> this happens. The third patch corrects an error in rxe_srq.c where
> if caller requests a change in the srq size the correct new value
> is not returned to caller.
> 
> This patch series applies cleanly to the current for-next branch.
> 
> Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
> Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
> Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2: Reverted a partially implemented change in patch 3/3 which was
>     incorrect.
> 
> Bob Pearson (3):
>   RDMA/rxe: Move work queue code to subroutines
>   RDMA/rxe: Fix unsafe drain work queue code
>   RDMA/rxe: Fix rxe_m-dify_srq

Applied to for-next, thanks

Jason
