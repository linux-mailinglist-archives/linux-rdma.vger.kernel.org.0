Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78663F315
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLAOqA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAOp7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:45:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391EA9CEC
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCChLEQOoQMzrLEvdmDzXc0lkLHKMMQ5XdcoWmodTXhoMaqmLJYuqQR5Z7ZVO2/d/AjG0TdRfrDM7c0WRlGUVyvw/yZO7PIfm8spWuXezdy/PmfpToOs+a4PWhCoAHy4xTLg4yxyDUPAjlIQaVQ7g4lRIKMQtp67CwFQL9B5mqfgKBsw2PHwzAV0jdWkGnFDxCpmjFS2Yx69AYdvv8RAAPbAWrV3E2ybS65I/7RQRwZBOq/diuY+6yTD7gtTZvVLhVe9Dj2P5MnjDBStFZreRLYekwvtxwYPmgpATvQZiC0yAlMQaP5CSoAMOFWLB2nzqVHPNeqVVGMyvdjsGg2VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSsUEmw/xURRJZeQAV4D7/K/2DbNX4ffE/bdOM/EvC0=;
 b=Nfb5IKz16n9vFUX7LjvxgW3ZFBT1F1MFj8wPrv9q3B2gGQEkaOHJpxyQf5I91MESb4yp1GIUzedKbKd0HE4HjhopEtTxf3FLXCWOuYRd0lQrffFfk5ltj8Zkw6fVwP5PPJ436ae1DOhlFiKm1z0ZvNw7RlFxKBMFP0dlExaopUTPF3kGmZW28B8xitpGeExpaZaVhB82+3lH+jusZTs5ZPMKsjqnNOAGX+sudt2FWhqzWKJ9x/S9or8izPKrmXrT0xHYO7OMjsLHmDnaL8kI+D7TiQhUzlt2x/dKMRYmZ7zN9ARx+l9ylmcKZQo1JUt7I1IF/9K3Lmqm2zfV9xu2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSsUEmw/xURRJZeQAV4D7/K/2DbNX4ffE/bdOM/EvC0=;
 b=sVVDgGOtZCEWP49JpQAS671OyqewyZCUMnBuUVE8CAZSnle3D96PrfoUN6dkXg8O3pK7GAomLv3gbQ9FJHtckXujHnpHpeaVkV3CKkpZ1DD5/vLoj0Az3Nb5X3qON2GUwU/ghXO1JSao5jzIi+RKrNHR+0Yf2gna+gn6cP64xx63L9hX21LWIVWggkDtjecmIofueHW1LBi0ozMNGnbajDPLLpNKVMYzOaLCdY8ZV0/s814TPrloFRWw8Hf0QJhZvMplILXyPl6us0oMFAJ5gVAa2YpTExjqg0uAVlB5Z2KDGsiY+tHhkUkZOVdGu7smyiO9+tbQDEEsCDFXI6iMcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 1 Dec
 2022 14:45:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 14:45:56 +0000
Date:   Thu, 1 Dec 2022 10:45:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
Message-ID: <Y4i+I5P1GApq48hR@nvidia.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <Y30o/2LDLO5bw+tA@nvidia.com>
 <c10c62d4-fee9-4824-1383-8c6cdcf1c71c@fujitsu.com>
 <Y4ik9iEfvMNefraR@nvidia.com>
 <5fa61fdf-b161-7699-c551-164be118d80c@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa61fdf-b161-7699-c551-164be118d80c@fujitsu.com>
X-ClientProxiedBy: BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7c598c-2a2e-4b17-0acf-08dad3aac0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOURnZYuxaUr1hrhwukqCrp/HSomRvPtdZ0iLqv/viPkZfO3CexdZLLlREGQmwG4UKgfpUPSRflPMAsStlI3b9p5AnlCF/nVCEg7Gd86wnyDIEtkAd4k8Z6Vj/up68DkIn99ZlHGxCmOwvN5pqQqSGqKvXx7aPKrlGjmJ3RkheKJqHw70Kq3ViDBS1pm1n9fe2Qpz3ofS53BQDqhXzrdJNaIWZKHf6pgT5Vj4wyLYRdUMlrvmk7gow19K2erV97+egSoQuuOBn/iqDydqwoOjhduksqR5dtxdmPiZ2PDICqQYk/E9SE2ebKYIRChjWEC+GcyUjD5KkEenakMSIT1Iao31bFJwkxpJHlPTcJVeXt3/luVYxFEM9dogbZ6Rgp3uap7uOVwkm9cyN35WHOnwu+Q+IwdJ6OKPvhOzX6M+ISLdZc1iF/7ccKYF9MYAiIoC+Xt2KWCPjrqJWjzdWVictkYyESniZNuwMX4AxNvc6w7Nhx23vPVboGIjyBL4FJroIRws6PVE7DmmLD0CzLB9OHf75v91m6fK6V18iKZYVPQmePNKsrPhny6MwV2LV+BJlY9vXrQbzkd+IHMun/0/7DG9rcrurBj5yegwzbP0/yIrkia8lw7+Yk3I1TApNA2aGABsVrg0a4vlhXqCnPpqPCRKCTBbIRRputIqbUKm+YThEuVm+1xRU9tC1vX7OO4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(36756003)(2906002)(4744005)(8936002)(86362001)(5660300002)(53546011)(66946007)(54906003)(6486002)(316002)(8676002)(66556008)(6916009)(4326008)(41300700001)(6506007)(6512007)(2616005)(478600001)(38100700002)(66476007)(26005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0HAW9VJmp5Sqf+Sc7uv9UTcTNiAEKHkm07XjwhFqr1/3dM34Vcjss11VwTm?=
 =?us-ascii?Q?W7o2lQ/o0aBuPAECuWPUb8yzIq+cvc90ijVR8mJLtIm+FiLCIryDHUGOqVn7?=
 =?us-ascii?Q?SZlckNFr86JcPoAjT0xzzN67eIR8dTVy9DxBq02fGMHb9qfmDFNF21elK2PR?=
 =?us-ascii?Q?/6MKskn+YX1fptNrDLpITbS+HaiVtDa/0YjrGebDQdHsECjks+GvjWR36PVw?=
 =?us-ascii?Q?c0FW/ZvuWs1+K8aB1ysiKWG9iu2PPHuvfHLVggYbdNLFB090Few72qzfdQse?=
 =?us-ascii?Q?zpvQ7o7DA9yr1Iyh81Zpk9ODMeKGClbbLkAROd+ZSFLWVpL8+eZmQ8TRdXF5?=
 =?us-ascii?Q?Z9FOdpISsy9A9ASdgYJYsoq0X7Gu+YZ/+lfOMbgfTvtqaKn+plkME5Ra+BsZ?=
 =?us-ascii?Q?oI/2D2A3IBCh3NK0cW4OiSyTH/VT8OLAP9mtLRrN0TmIDoZx7IOdSoNWh4Xa?=
 =?us-ascii?Q?i6lc/7uQ6SRwFoMZZ2SK6eAcTB6XMQ1iPuZxRiS4jLaJpuW5GI/w+t38TiOA?=
 =?us-ascii?Q?0oPJJqzIL+bM/xbeKTXlmmeKYFFlKIoIgyzFDB2shANGWMXwBggH1JXVdVHL?=
 =?us-ascii?Q?UFgiVr3k7BiXS/rFyU1UW8hL/HfqmoI6hWS8538HCYQsGLqBDxYjbhKwuiMI?=
 =?us-ascii?Q?jWwdNJkJ2kiVPrwUANIjqDBCLttdYEW8MzD8DxIJq4FvVVI/fLT29el4m964?=
 =?us-ascii?Q?PGu+WwuNri8kqUve+ohiv5hwccSNlJP60ScHBMaJczqtmgD3RC6w7Z0Ur+N9?=
 =?us-ascii?Q?nImGu8lSf8jLx9MTKW5ptlqDkrJHnJU9lKRoUesZlAgJEsHq/TPE/7zg24um?=
 =?us-ascii?Q?Vzxvfkx0QkEqxUMsBvpPINgQe9WLItb45t5VgJtRojozSZ97tm91xFJADLAe?=
 =?us-ascii?Q?Gyb0E5QiCXPLbivEEuyxazPRyJOe3uU53Wwcylr5OjSn36P+7lI2pBr2Sf2O?=
 =?us-ascii?Q?Gjk+3KxpIZE5zmqiE1ZfKF1noctuoxbmLEcJc3IywaKZnXNLwEUOzwtHRVdu?=
 =?us-ascii?Q?1X7WbqpZ/LwnBhaRAfUgoPOU5f3VRM8ITd/NrrtkI7e5MmtnZDExYEUGGWGF?=
 =?us-ascii?Q?klIv/+RFb/Yiphc64SSFFs9jzZLBU3TtsrygHB0rpHgcneLzsodpljgrh2yU?=
 =?us-ascii?Q?cPMXzS2At6WFzqVt6fUAAO/anNrHQmd2Jpr/kDv9P1Phs8lJsKS+YbWrN1dy?=
 =?us-ascii?Q?jxqwdRZVPVuA6PN4WtFjiOz3MMVxd+6+zXrYp41q4brabA9G3EE3IlG2bpnM?=
 =?us-ascii?Q?V47Q4qK6nWW1pzCF8r3UNomTAriSbKmPvLFFNqtYMWsUgKTUZOZrJfu0lPNx?=
 =?us-ascii?Q?K+dE0QsZuORm27WVJaelPE4tntsj7IelTq3W5w50Byr/uKpdKFNodwGODw+E?=
 =?us-ascii?Q?W91XJPR9ys56muQ+D+OgEMeR3wJIyKQ7tpdn3+C3jEznpZ3AVt3/P0Zv/bg5?=
 =?us-ascii?Q?26KxEY+K8zdXUQfrsuvTYb6NqVrLg0bsuNlsWJHg64b44Q4YUgYGvh7BDPJK?=
 =?us-ascii?Q?P8xb5D7Yu/IoGB+wPi0slo8zq9qPAVC2jnvIL1AztsBGs09qp6LWV6klKroP?=
 =?us-ascii?Q?wst2st308heErq//g8o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7c598c-2a2e-4b17-0acf-08dad3aac0e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 14:45:56.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wa2IvLwN3qZFIpcHC+pJpYneoj+6ZYyLStrR+sdfUPRFYZsmJfYOCibZGEkgus7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 10:16:15PM +0800, Xiao Yang wrote:
> On 2022/12/1 20:58, Jason Gunthorpe wrote:
> > It is not really "empty line" it is that the last character in the
> > file should be '\n', and all files are like that.
> Hi Jason,
> 
> Thanks for your explanation.
> 
> I think my latest patch has added an "empty line", right?

yes

Jason
