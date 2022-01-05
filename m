Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3B485976
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiAETtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:49:17 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:28705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243691AbiAETtO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:49:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT9uujyv6frWTeAWhMwuCXchAynWKg7XKo3j8iiXcbJRmif5QJgVP4tfYfYZDuoc20+00hzQiPQVxYEkWr2qUK2fhrJpXsVwlNWb+JX98HxZNlF5RP2CmaoCE4uKq3b6b73CVW1tvAx1aY6J/xrr0amWfNCUn0Td61ixMsOdpn/qTnijwLMIDX9iA5WiX0QviHlvDn+L0GcD+BLE6vimot91Vf25kgkKMnWp2iFKZ5cQ2Jcejh6a8oAwVNsFUn3oJ0dabU2oPh+dXd/QM7P9q/RXW34I0jBTpH/CPjenCzHtwx69IZn5b2njy1avaORlqW9Iz5SabobMoT2cGYp/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ2c2L4ZchhyObGOQs/qNDI9KIbcD0pI9KjbuOnNjrs=;
 b=ReZxhDw1EjvUjjwMaYtPb70C9OU/VGGRNrTxEOyV82ksDC+P02siZLkeJ+/u+uBtJMKVaXAhYROFt3YWQTjELxNuYH78CFR45BfZoLedvqCbJo/oJuRcx7ner46DIcxXa8VHGGxF51FymR/hwTlvbxG34nZoBulHlW3K9+3gAgM8zV/Dil/uAeGbhv95PrTacFJgUKy+PPTutIlSk3+c+TKQGT3w5a4FIBeHqr5EHU3aciQRR0o0QFp9bTnVtDCXLMkaRis5P8WZAB0ImPsxKIVXb4xwmT+JoXfQ9wqSe9IQC8/QJGk01N402E/QZ2n8tjNnx88E0ruCrchj+Iwrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ2c2L4ZchhyObGOQs/qNDI9KIbcD0pI9KjbuOnNjrs=;
 b=BS7Krov4Rh8dbWqEpavGY3tVNRPbHfvOVVKprgLcl8WPGtHmMPu3M5NLKA9wR1UWb8E6YRZ/d1tx8tdGRc6+DtcWehLuS4vFobCg8GsltLHfScChNfmXXsXKABq0bGyK/XnG2UPCfGRpnL8SAWGFGaanmkCXI99EhSKr0JGwFihECuj+4nEs/Luj6J6pEYoSFHR6HpdX8g+XvqiKztkFzPJrkJLTChHc5XCjrW/H/cy6gS0HxSDAmUc1vbVJx+RjWgmrcjP7V+W/etiiFLMX3Gxr470PebK1QqzCSPbuTx3WgGZ2z+YsioGmFr55vba8jwFoejNr8wt8ETrVyloGsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:49:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:49:12 +0000
Date:   Wed, 5 Jan 2022 15:49:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mad: Delete duplicated init_query_mad
 functions
Message-ID: <20220105194910.GC2872048@nvidia.com>
References: <af6f35c590ff5ef56d0137351b8b295af0f7c13c.1641369858.git.leonro@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af6f35c590ff5ef56d0137351b8b295af0f7c13c.1641369858.git.leonro@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da28c878-4a9c-41ba-f6fe-08d9d084729b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031A7E8AD4A944148E7C89CC24B9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kc7dcaXgeHayYQYEaoshtAgI3U4NtskMxoZqOMiU8d5YUyhTxB2molpAeDC9uSLXNvON+EPOgGj4ONGPkbY5v+fa/9gm4s7pKWBuCWYECO3IAK0tivgI488UEPOebynAC4Rs30eEeZXr2BSfL8qdZpIhcQhWZeR5tKghFijFRlDKB4EwlryqIAiO+W3EDIs0QNGG814AoTBsD9ktbyjcIhN8I2M/u9wONPlusewHjyJpSOeRhXUAmOxIy/uryDUq0GHzQD/rPHCwc4kyrEJ4jU6Rl7eDfiarziNlr8vsAg8iyzb5jIuZauSeWubs9XgvFB0O9Bs7AWL+IFw1Rc2fvheg9MKq78GNgPKhkPPVhqkiXjvkJJl6fBE6RPYNVlZESwVdRcIH4t3s6eVpev7vPu5YOSJANa+qkhUM90IdEBK1217C/qB4q+ldtqThiDFgX+VMOuyMgMB2z1Y4HgMhOZO1khQGaHlBgVdmYdMIUDNRN7Ai5YN8lEbhKyPhz73knUC/6CeLvX87JJBuVjpCIC/tUmQXck4/xwB+em7bnoY4dq4S9f845gKC+rl0/N5zeZQdhnkXCGUVE0NFH77Ird1VyLNzq6cbHdsGSD5rtbaNdWQieKhNL0+98ZpZu0MktEXpT0QrLdPQ0JhdYsxs0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(36756003)(8676002)(66946007)(508600001)(66556008)(6916009)(4326008)(2906002)(186003)(1076003)(26005)(2616005)(86362001)(33656002)(6486002)(6506007)(6512007)(38100700002)(316002)(4744005)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWY2d1l0UUIzL3pBR3NxYkhWK0YzbTY2Z1VmNG02YU0vdlFCQjFhNFNrRlYy?=
 =?utf-8?B?bnE2TlFMdkN1NE4rS1FvRFREaFZ2RmZraWU2andpTUhkajJVZW11NzdZSWxa?=
 =?utf-8?B?UGRNZFowZFYxZkZRMS9DZDF3YXFNY0lqNzNVMGZFQ29jT1YvZDRIemsxenc2?=
 =?utf-8?B?OFB1UmU3R21QVlBGbkdxT0d3eUZiUmZacUNYK2VYVzFHY3JjMFFWWUFqUldN?=
 =?utf-8?B?K3A0SHRWQVJOSEhxTHUzMVhMeENFTTd2S0xZY1kySTRNTC9vRXcrcUhNRTJT?=
 =?utf-8?B?cjNtSC9mdGhVMENCZFNMcHFQSUJZNHVNRXA2OWlOUXFtQWh5MGZSYlJoTEYw?=
 =?utf-8?B?eHRRelRycExGUHJzeFRBUE1idDczVFU2dzB2RHdvaGpLbVpHbm5qdCtVTEhv?=
 =?utf-8?B?aGU0RHN6VHdyL1pHT0E4QXJ4aURGeWREQUZHcHpnV2pmZmFvUmEyRHliVFVR?=
 =?utf-8?B?cDlXeUNXa1JQRW43VXM1UWlXNzk2M2NUOFRwT09reEM1alRacXRuc1l1aElL?=
 =?utf-8?B?SzU0QzNLQnI1dmg1dGNWdDlWY0luUC9jSTQ1djlsVk42bVltUFBUSnJMekwr?=
 =?utf-8?B?NUI3dFZZY0kzdmxTOS9uaFNKTEljbkpHM3RnVFJJK3dmZElhKzVhdWtuK0tr?=
 =?utf-8?B?ZlZvZGhVSmMwOUd1YmlRMXFjYmVkL3dyZldJaHlKcS9zTms3SithQmNrOVlS?=
 =?utf-8?B?UFhzeml0dG1MRTVVMWZWaktwc00zbnVvTm5TY2pOUVhVbVlJSm0vVEN2d1F0?=
 =?utf-8?B?dFBIUGtmcWdzNkZNdEpiL3pxV2tvbFB1Ukc4RlAwdmJ4UjZ4TWFjTzlXdkFN?=
 =?utf-8?B?elU4YnRGTGZ4SHd1MDcyZXRTeU5LOXNDMW0yTHdrSjZiejR3MWwxUnJURkd1?=
 =?utf-8?B?LzRrSFZXL2dQRTZ6U1hBaTY1eTZtbG84UnJiVnMyd3huNVhZLzVjeUJrSVo1?=
 =?utf-8?B?a2doaUVKTlM2UkNGa1lGNURsaWdVTCtqTVRoNUJ1VGxrWS9KZmFwR0h6anNL?=
 =?utf-8?B?Si9lRkordjlML21JMXB2QUY2TkFyQ3Z3ODBSVHAxVlF5ai85OUkyUkJucGNa?=
 =?utf-8?B?eGNyMDJtOUFscyszRzNibG1ncXhkTlZxa3JibVZQVVg5b2NvNDRqSUNIZWZj?=
 =?utf-8?B?L3VJRU9jby9GZ1JuVEo2VmozL241VGpMVnRXM21KSjZ1NjFsKzNKYmQ2L0ZJ?=
 =?utf-8?B?cEtaZlc4eTNHaENENGswUEQyZnVYRU1SeHpyN2plSWpZSkdycUdnbVdtTTZr?=
 =?utf-8?B?cEd1WG9kUC9KSTkxYXFXNmpjdG5zaWw0NEFZVlYrcmZlODRZL3QyM3pyOFFn?=
 =?utf-8?B?SGZiSXh3TEZkWlZ4RzQrYldyMEdHRSs1YkgvK3M3MkNpWjhnQXhZVHhwOGhF?=
 =?utf-8?B?aW44bDczT1VRZzdGK3g5Z3pxbUM2WU8ydGdOQk1GT2JLY0ZJY0w0dEo2Mnhx?=
 =?utf-8?B?ZWRGTnVxOHBVb1B2WVlvM1NrRTh5aUZzTlhxV3ZvM3oxbW93ZEdlekxlbmxo?=
 =?utf-8?B?RE1Ya3ErWGFaUkNJTDBOeEJxc3BTWk9ieHVaWG1pR1dxR2IzdXRKNDFiblhZ?=
 =?utf-8?B?TGNOaFQ1b0wwU0RxZlNac2E3YjM5b3l1a1pqRnI0KzUvaDRoM1hSNU5rRE5M?=
 =?utf-8?B?L0h0ZU1KbHo5L0hqci9mMWpsUUJvWGVZVXBUQlJ0WHp2dUNqZlViNmhzNkRj?=
 =?utf-8?B?MDYrS1pyRk5pRnl2TDlDQnFMOE1GRjFNMDQ0VDNoa1U2djYyRERzbWs4VEpN?=
 =?utf-8?B?eVpkNitiTmlGbG5qQkVSMGpzaUVLWWZaQ2JxcUVRSTRRRm15bWQrVG5sdjQr?=
 =?utf-8?B?dnBZNnhQNWx2RHU2YnpVT1pub3kya2NJWkRGbktPVVhtOGw2Q2FJQmVIQXc1?=
 =?utf-8?B?eDB4eXVCUDM3VXdBQTZUYjJNQk9ncEo1UnhvZlUxR2FvMkNBd1FUdmtwRnV0?=
 =?utf-8?B?SUwyN1FaakJJMzk0cjJTNGpIbXFWakJ5UW1sanRmVXptMmE4Nk9vc2IyRXBK?=
 =?utf-8?B?SXhITk4zVVRpMURkY3VxQ2puVE94UHR6bjRTT2lIMzNHcHorTndBV0xIWFZ1?=
 =?utf-8?B?YWhtcHFZWTNpZHhlenFWR3o2Tnh2OElYNnBJeStqNHQxc0l6c0Y2MFFjblpD?=
 =?utf-8?Q?jROw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da28c878-4a9c-41ba-f6fe-08d9d084729b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:49:12.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bPRaHm44GMDLSPg5R3BhpIMJsXigJoDTk0qoRO3sjMvD0QFoLKKQCiX1AC7KfD/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 10:04:56AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Several drivers used same function to initialize query MAD,
> so move that function to global header file.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 24 +++++++-------------
>  drivers/infiniband/hw/mlx5/mad.c             | 18 +++++++--------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h         |  8 -------
>  drivers/infiniband/hw/mthca/mthca_provider.c | 20 +++++-----------
>  include/rdma/ib_smi.h                        | 12 +++++++++-
>  5 files changed, 34 insertions(+), 48 deletions(-)

Applied to for-next, thanks

Jason
