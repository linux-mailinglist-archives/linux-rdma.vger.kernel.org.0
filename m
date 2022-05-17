Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1385552A0C9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 13:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbiEQLyg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiEQLyf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 07:54:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A30419BB;
        Tue, 17 May 2022 04:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgmn+5lnnQWorT8kc6UZPp1e/6ydZsfk7dBGb8Y6sZW2ZdaZ/vVsMh9FJXvP/SpFArmhJugdziAZtriX92vCb7IyXebykFe0OA6tjoMUbCbfrSJmztkrhTVQ4GFwj2iB719DuJNX0zrs2F+0wZysjGXMCw1Vxfu147+baw+ARrcWNxaOze+tX6MYX99dQ4CuPXrrJKNrhhdk+MZ1J9VTxESL6HkEYHF659NfM7xG24upNX8VV790Lbg2plCnjR8tfjZW3gQ7EGsmIODCBusLQvXuey1U9zo1aqIbfYtAZicfKyeLly1jBbHJ2fAuSGx3ZLRjIsKQjhY3bP0yRk+Eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dlkMzG2LdXYBzC89AzKhOr9LVp2r9sjeuubvERx9M0=;
 b=jdfWNAaHORMGZPQZSTOeJJr0X7LnabrYVBGH6YYs1feItyN/S7rS0DKEVuY0eaD3QwgpMLxJ+vlkgrcaqNj9K0zYpGmaSmviQZ9BgdLm2fFQv1uNdcbIEPGRLqrPxX3ppx65HCvrMbsJ2fUZkJEEYgTK1AfJAvV6sUg3eKO1AXGTW9hwe8q4xkb+ttccZrjXK49VUlg3S7FTDFPiO5NlgDBNVSPJTT+xbV2etZgrNNuxVKddiqPm6l2+4CivjfZ1GSUYVgUMW2/g3W6sXIaieRjWyFvLO13XrnWUNCo5ArmCy6h+UV/LLaQCfdLRRZV0K4yQtOupIYG1i2mgApjarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dlkMzG2LdXYBzC89AzKhOr9LVp2r9sjeuubvERx9M0=;
 b=K9XnCcEsrEtR6h4WsVYPzbXClkvhZfQWilBTaCIOyCmFzWT6C3NZkgaWf6QjCEAv5bCyAkCxDRBjmEHQisZM2/QelytWfxw5cA7UedYzrupxBT/89HB4bEAUmwtNPvsG6zrPCOsa4caqgHaA5l9F7X+lqYOqJWs37jAnJHnF6nr9NhRJubSu6KvtfpJweO7XIIYv0uQ7qVSFWIbExEcVz8nTuVSV9lbXkbfeupk5uHImRXy/DLZdNfbyWXSr4e0c8d1hhhMvgk3HwmgHr42nZaSB+TZ7ii/wCJ9/QbLTl0zOplK346WtsawdoWyFXEUdvysewGsIL5WnMKeePuoUAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 11:54:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:54:30 +0000
Date:   Tue, 17 May 2022 08:54:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     cgel.zte@gmail.com
Cc:     mkalderon@marvell.com, aelior@marvell.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] qedr: Remove unnecessary synchronize_irq() before
 free_irq()
Message-ID: <20220517115429.GA1901088@nvidia.com>
References: <20220513081647.1631141-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513081647.1631141-1-chi.minghao@zte.com.cn>
X-ClientProxiedBy: MN2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:208:fc::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4853df3d-b461-4181-450e-08da37fc0057
X-MS-TrafficTypeDiagnostic: MN2PR12MB3598:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3598BE7D2CCC0E6F5B610390C2CE9@MN2PR12MB3598.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9I79xQ1NQ2yndlcLV7DhnfZilRq47/oOAnmBjdeWq3LVYNGrA/9Z+b2swT/4gIwWKeGTYVKQAQMJmVeuSq94QF9Mxrz+W/cQph/I7tXRMbbVSaTbITA5SdxCoGRV3k9bQoBiXdqJzXjmBNtQvg3TMPAydBVTZtAdOkIfxtgVOfXQLD5K7kUA19zWzpmq7/IH40kqrPXb8zOqySHnRBQHEUboHCP15NQiCn5Wdq9FUQSDPW0p3Q5HviD5mzs7FR4ifE2Om29qd7WkKATaPeZNCmHFEG0cGkhZBf4FMds+3JFr6dDU1SKUquZ3PwGsV7E2P5VnxNzg85vJkU9AgxQQBeWuRCXLdlKETXpfV7Ee/6SZNOqYtrMLBu8IpVVQdxmM5Zib1GyVz+N4Xi5ft5bm7EI6uRMxnSRBnRppog5ACIESOEQ+LR30bF5sABMSkvceY8T0eaBemdJU23VaNzDEBVUr4MfrVzmOIjoRr1bVT5NOopSdoOX8TIpV/fR2iaJpRvbGfH1kTITJWYu4TYzFjpOh/0+4AMiBIbeE8M33FlngD82BS5kxT9F+DPgXA6kqohG2hEy8qvLzaU6vSfJ6F5PfynOk2PTfK81XtTCPXBAhzs87v6qriC5PDaKP5OvdxQq+vQ5o4E9GbdbOQUcoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(316002)(38100700002)(33656002)(5660300002)(4744005)(508600001)(66556008)(8676002)(66476007)(6512007)(26005)(54906003)(6916009)(2616005)(186003)(1076003)(86362001)(36756003)(8936002)(2906002)(6486002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRreTdwdGJzRHFKUXhXNS82REhDOXh1dlFMQVRSaE1jRVVNUlpnS081YWRQ?=
 =?utf-8?B?MEZsc0lZUTVJUC9xRUowbzR5QlRMZnlEZDNzRFo0OTF4c25WOEt3SjltVnJs?=
 =?utf-8?B?OVR3cTNxN1dNWjJzeXFlOVRNQkxUZVZSdm95a2FYOFpuTGZLcW5xcURqRkdB?=
 =?utf-8?B?NGRYc010d2dyUVY1NUU5MkkvYnQ0MVg4a0Jpb1dTTDVYcUZGVlZPMnNDSHFs?=
 =?utf-8?B?SDdGNEdZd3NxMG5JL2dCU0dscUExUGFuYU1TakpFZk43ZldNRi9IMzA2bElD?=
 =?utf-8?B?anhzQ2xBaUFJVm1CeU1YM0lOVmcwanJ1ZVg5STBRL1ZqQnFzMFNxNDZJRGpU?=
 =?utf-8?B?R2VLNXM0QUIwT1MxdUdGRkgvQXl2ZktzenRuMEdQOXppM0JlU2xnUFhpTVZp?=
 =?utf-8?B?bDFvV1FCeWEzY1NmVnJFc282QU0wMEZzL1hMYVRUak4zdHk4ekhNckNOanlN?=
 =?utf-8?B?bFNnTTB2ZlErRU5laTltdHdhbEFXblJzT2szbSs1bGtDNEI3OU9lWkRYeG42?=
 =?utf-8?B?ZFc1R1RvNXpTSE8vcHlhN2EzdmJINzQrblgxN09ndmlNZThWWXVhY0xRbG1K?=
 =?utf-8?B?TnM0QUYvbDJibUVOUXJFT0RKNzdHcElQQXo2eFZpTVNBZEk2cTRucjFJbm42?=
 =?utf-8?B?SzhwRFJremMxaFVmT3cwVlJBVXZKL2x0SmhXQWtUNXp1NDJ4YnNsZUR6SFRw?=
 =?utf-8?B?RDRKaDVlR1lzY2E2S0lMcW5HUDIxMEVxanYrY0xTUnEwbDdPdXB1Qm1WOTNP?=
 =?utf-8?B?RVQzT01ycmFTdmhoTU9iNThrT0NDb05mYlkraEJmWCtGZzNTTjNaTzJ6OUVl?=
 =?utf-8?B?aHduNTdFVjJ4anJ3OTZEclhJSUZPMnUrVTNqT2x2MERRcm03VHJLalhrQmZp?=
 =?utf-8?B?cXpKSFhvS3VxMWJCRUdEc1VhQ2k3bktYZFI4aWZVeSsvZEgxaG11MDBWR29C?=
 =?utf-8?B?Y2xkeG5OeGVLS09tY3BEVHdSbkNjY1pyLzdITTVXZHRRZlN4YS9FVkJMcXhN?=
 =?utf-8?B?eURFemhQb05zcVludlBSM24yL0h4VHF2ZGMwU0JMdlErVTBSdkIwRkljcGhU?=
 =?utf-8?B?amlPNE5HZ1RKNHdPUHJQb3lKbHJab1VSSGZYWXNwMGFqVmlRQkdRZEtmR25r?=
 =?utf-8?B?RDJYamMxaGFHakcxb0MwT052a1dtQnNYdlZSOXFsT0NmSVRIQWxUN3JzL2Nm?=
 =?utf-8?B?UmcrRVJ5bmVIYVQ3WGhja3NJZFJReHhrSy9ML2I2dmlQTTNibi9mQ1pydmZN?=
 =?utf-8?B?TXV6ZmpobW8yY1Z0dnFpVkFIcDk5NE5aUXBabzB5Z1dHakZ0c1lOckQxZEY3?=
 =?utf-8?B?WmFTcnhESFpUSFVIR0pTNlhwdW5EVGtBTFNHYjRLbFRRQVJuRmxGNUlxaTB3?=
 =?utf-8?B?MmN3V0JpK0RCY3hjdGgwN1VDWVoydjUrZnYxZlZ5YzhaNEdJN1RZKzFXNGMy?=
 =?utf-8?B?KzJsQzV3d2ROckNYaVJCNGppbmZhTkNkcEwxZzlBdXBhQjA5NEFwSUJuZWtu?=
 =?utf-8?B?ZVZBblkrczRyVGxtOWZpU0t1TzZGdUlFVVJWVU55UEZvR1RIK01LbTlIZXpS?=
 =?utf-8?B?ak9XOEpLZFplL0YzOS9YTW1iUi9tZytIandSRUZ0UFNrUWRGTzBkbWJ4TjNH?=
 =?utf-8?B?V0xOMUU5bDFyWnRuaFptZEFlWndUb1dreHlDekFNWFltWUJUdHRVa25QcW1r?=
 =?utf-8?B?dWxMVWlOaEEvaTFSdG53K1RvbmRqWlU4K1g5WGxseGc1MC9kaFVWMWhkT0VN?=
 =?utf-8?B?RlB2ZFNsa2JIbnlRTmU2TGxaT2pBRFhCMFF5WHlQdWt0WHV1UEhPRzNkUHRy?=
 =?utf-8?B?VXBuY2p3THhVMDY5SVdlNmlOcXQzaTJwT0ZxTk5uaFg2OUtwL0tmaDdTKzlV?=
 =?utf-8?B?aGdVSGZnNGRCSUdNUEljcHV1ZVp5eEhjK1ZpRllsVDBiSjFMcGp2N29MQ0lI?=
 =?utf-8?B?c0tvZWJhbXNPZ1FZRTJMNTZEZldHREhJd01qS3VDWkw2Qk0wcy9vaHpiejR0?=
 =?utf-8?B?UGI0SFR6THAycFU0UUR1L01XNzdSSUlHU1FuNENRN0JBcHI3ekxyVGlKZXE3?=
 =?utf-8?B?dmNyMkh2SDJMSTArZzRUUXVXOFVQUzNkZHlTWWdiSEdmSG8zMWdJTHZTM3dT?=
 =?utf-8?B?NnQ3ZHJaR2E2eVhZck0zbWZFRmtXd0hTNlJiM1kzK0RXNlFMSHQ3cXJkeWEy?=
 =?utf-8?B?bEY2STR5aHpiTU9nWXRmQ1dWajNsNldLYTVhSTRrWEtrZUh1dFdDd0ZjNEti?=
 =?utf-8?B?RXJ6Yjg5Z3Z2anhVV25JYXYrQzhCZWFPQ2ZGQ3pBM05sZ1hXVTVVa3dOeTFQ?=
 =?utf-8?B?UjZsQjBNK25hMzRjN3oxemhDR21MUkljTTBBeW1TaGtNYXRNQjErQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4853df3d-b461-4181-450e-08da37fc0057
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:54:30.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWPrlKdEzrV0yVIv27wqelEkVZeds7nWAV2687GR8uw7G6rNPyhs0mFxO3oi6fL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 13, 2022 at 08:16:47AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Calling synchronize_irq() right before free_irq() is quite useless. On one
> hand the IRQ can easily fire again before free_irq() is entered, on the
> other hand free_irq() itself calls synchronize_irq() internally (in a race
> condition free way), before any state associated with the IRQ is freed.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
