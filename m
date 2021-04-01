Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D7351F13
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhDASws (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:52:48 -0400
Received: from mail-mw2nam08on2040.outbound.protection.outlook.com ([40.107.101.40]:2016
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239518AbhDASvA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:51:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt8fRj6+xX/EUPTXfgP/5fv27+cY3iURkmtzasdS1nRpemEc98sDW0VtTBqEx4/mH/m7IqXGTNoDYk783KLhVy+y/lWP3vk4UhNtOgBmF+cJjNENBdafgFSr84uyNROAYAPfjmg4ZvNNXJ4mOMMXk/n2FH7z3lG96U/WyV0ZQOLqcgrkElqH9rtNUCCQAorItiv4FGP2dYEPqy4oyoqEGeZ1ltW2rl2YbynplKtxvYaVIr907UK8K/SlH3yclsRMUZXPwfJWG+fHKCuVhpInMharqotUug9EtgbZzOHHTWi/7qlKmw6cbARBC5z/MoYszXVM67SvXK3RRkZE4Eg4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFWNilRhUNC9sKyWYFc2gvCcoGH7e+Z+gwB8cz+EZ4=;
 b=n946TSoJjGi2+HU+ZJdVQnpJ00HkZH96QRNCt8F9NYENve5pb/j+GSymG8SWFh6M9mbDepZzKqWB33/r+EmTfSY5t79JAp1fbRETq8EVZAzux5sdx4bcYt5BdJczkO1RPcxtapi55hUAkkF/wAcUpoIewYUSS2sdP92mhc2MEjtNjodjjHPmfn8xjds7BXvE0P/5I0gUEtCHIat7kUQ4LWOOqyNqSOldIkRpWamlgP4y+prYfw5Q0CCdwObpAPCqYKFGHb6mOeMe4S/A8PgROMzVhKaRAuWld+ZOJ3uPh9YYRigkGsdB9IVj5oCKHKE/11ju1r49Y3dWiGf6GrsyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFWNilRhUNC9sKyWYFc2gvCcoGH7e+Z+gwB8cz+EZ4=;
 b=sWe72e3aGMdpriTRLENKXsTLcH7eMci5sdLMj1WCzXtKqRVxF2mN+v+Z7eWc1RctPdqLo6mJHKSNKm0/O3s9WbDk6veSc9A9Pe/UpkuirXqRJDVYQiwIgcm3p946DfCcK8i0/qW6wwuKz1rCzogl9zowK3TlGCk98B2GlhN6vDJZC1LPfKLfaTGxvSvMMHwbOE0ZMq66Jqszh5U6PKYJ5Ig8H2HiNPEFzZpcmA1+EeW3RTV6EfimHzPaqT90oGxFHL7hhh9BLKSVmscU1wAxri8vrhs2FK0X3ZzWKI140bixEOrwU5gaTqAdJj8nMO5bumFthTC/g1GFp0YpXFtB5g==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 18:50:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:50:59 +0000
Date:   Thu, 1 Apr 2021 15:50:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH for-next 17/22] RDMA/rtrs: cleanup unused variable
Message-ID: <20210401185058.GA1651854@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-18-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-18-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0035.prod.exchangelabs.com
 (2603:10b6:207:18::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 18:50:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2PC-006vjT-5f; Thu, 01 Apr 2021 15:50:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0f0850-8938-4d12-5d73-08d8f53f1736
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2937A3C0E1CD01F75AD051DBC27B9@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUNvTZVAYX7XNMfpx4BpvZSvJprRdQYqnF3WbafbwLWZg6lC3JUtsW/MpuixtflbmXQrJIylulLNbBhNVbIn+4WdasKs5pHkoTXHIMAzbGgOxcJTs5EQulDbtZbiwy++2OsFYdTgE3JQNQLcvD91d7MWNZPncKaZWhUKLi/D1BTBL8G2pOpUnTKxF7hh0AqpOB/I5ru8IyJN7zWwHPV4Z5VIqW3rGxKDQKB8/8Y/Gr+SJETi+Rz7D7IaQbPCxBiMFBagMT9Ge7f35KVah1ZM5oW5ugDd2uO2+xQBz34S0HgsB3XUuYbE+GqtM/ApgK5Zt2wnpq+5iSawEEntC814izoZovRN0psYIHa/XHSbsYl8viITDffODI1w7ckC7d6hnazKMgnVE/3p/eLLICGqElClLlkKAvnK26IfOk80JcM7xDaKVTU0So/3UHbdgW3BJYKH7h53/g8ORlVDz+1ipNxPJ67HmiFeHkHbkqgn/9I4oaYUmmc40FkAwD508UT873x4phlA2mZ8sWKYeeTDZd7aD4Q6c2jL71NUm1BASqssPs6gAR6tGvmEVB8H94GkyM4+Brz9nDS8VLD5E5hBU4iWRjfv3nzxkMNMA6AHFT7ZdTCnl5L1hTlSQoux2HHK6gdcldKlT2dU1wHAabXB+wLJG57HRRrBqfEngsycGmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(6916009)(26005)(316002)(38100700001)(2616005)(1076003)(8676002)(9746002)(4326008)(2906002)(9786002)(5660300002)(4744005)(426003)(66946007)(478600001)(66556008)(36756003)(66476007)(8936002)(33656002)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Uiv0DOVwNlLJccLyfZkvdlJuMWs0bIDtsYDS3WjTWI6O1pUpg2y+PRRH2fK7?=
 =?us-ascii?Q?UyGiufXGRI8Ms6A3fAZv1lC57QIKIltDHrvpAfH5LKuz+mUMStnCW/Gq7C+H?=
 =?us-ascii?Q?bMk1osujGtbMNm63am2LlYAlrqOcf51gShLuz8/e5jS7C/SJc3DaPtgKXcYz?=
 =?us-ascii?Q?5Qv1/hnxPw8a6t5M2M/nxfEgBj8pN+JrN0IDv+nr2eXumtBhQJiSnuCprfkd?=
 =?us-ascii?Q?8AhrJU/J8Tzqe4VPVEbPH7N5aSMVnwU48e8TB6JLJLFFKGKFyYCLaIh2S+qo?=
 =?us-ascii?Q?1ufR2uXilxKiq5tV5okxrbRXUY+92KUOdV+1/XOkCxMUT/a/1holwrcSGLDl?=
 =?us-ascii?Q?+H61uhUf9YxTUaYotm1obLQIrDG8hA+tmw87H+kjrVJw1ledLx8kMUPzH/Od?=
 =?us-ascii?Q?1+A/Lhvq/eYm1OXqgOHy+Dd37ekM9UL1P5jbwX8GZmLzgl+AWTcufjFlMX3A?=
 =?us-ascii?Q?I2Z6uH6TKTdyjlXQ2g7YdSyTWth7HIGmieBUJXoV+NJZ9CWdDt72nvcAWK/B?=
 =?us-ascii?Q?32UlLD8uj0tCnuIsSojTP48aXualtHVjUPaEpOkGuo9lcWNPpBIrDiTplzW+?=
 =?us-ascii?Q?LVxeEN6CLnfdw3R3oNOztKBsDWEj9l15owMNgdfmLrOR0u3OaZ0goy/2cfGs?=
 =?us-ascii?Q?eDq5HJf+/IsRYsPzWWMmb299kBCn+mW7uC/PufWeQFtkWrc52KzBrDVKInTR?=
 =?us-ascii?Q?eNbZRFlFYGWBgBOqUh4PLtvJjgSV5gTVUvA1ZbUCQ3RP5TgMdA8hK3lndSDD?=
 =?us-ascii?Q?0SlcbKm55n594WlEfJCVt7iCx5GsRkn58+9jMXN74uQglzq3iAEx6LmXQwqs?=
 =?us-ascii?Q?rgBIcgB7ssomvVTaJECNScE2f67w0Em4qgK01Z9ONd+cXau+4n5PoYgI8OUd?=
 =?us-ascii?Q?7NMqkvo6VrOzF8AnxVkWH9AjQXWGEi0nXk9Qs8GgRv/oFMcgLB7Rv7hOzOK/?=
 =?us-ascii?Q?+EHMACHZLGSAfXftPyL2RMXzjzx0CgZE1fwP4IKPdj328P7+21ne+TY9f907?=
 =?us-ascii?Q?18l2u19VUOs+ihU0lXSLcu4mnqw7V03upQGKVO6qVd2beDbBKqZRJdo3C72g?=
 =?us-ascii?Q?mV7nXzD2QPkoxnxuW9SJbLKzrF+/ZUaA7FaMYcbsuklMfFe/FgGVx64C1I0f?=
 =?us-ascii?Q?fTjlVfmrLTGrN2Kx84rXnl8l4YV/bJ3DMFaqgve5MDgphZ+VvbiHdlPL3vT6?=
 =?us-ascii?Q?v68ouZICDI3Wi0nUis/zx0JksMoMVDo5TMK43DQWrMEZ4PH9np142kaR5iot?=
 =?us-ascii?Q?V3ZjxXLvbMjZBkeVD9XtfFfbI8TKcO1ETC4DlHK+8w7Sorv9kwY5lJW4s58e?=
 =?us-ascii?Q?kFok1WUbPMxjIdTyCL9nr7+SHW74jqRRGri0FbrxXueoRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f0850-8938-4d12-5d73-08d8f53f1736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:50:59.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYPYpAqf/EVfUisYt4hv+GrNT7j4kOIMa6wSctwFX49BllCmzJg5xLzU4uRJ0h7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:33:03PM +0100, Gioh Kim wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index 1dd772d84e71..bc08b7f6e5e2 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -466,7 +466,7 @@ EXPORT_SYMBOL(sockaddr_to_str);
>  /**
>   * rtrs_addr_to_str() - convert rtrs_addr to a string "src@dst"
>   * @addr:	the rtrs_addr structure to be converted
> - * @str:	string containing source and destination addr of a path
> + * @buf:	string containing source and destination addr of a path
>   *		separated by '@' I.e. "ip:1.1.1.1@ip:1.1.1.2"
>   *		"ip:1.1.1.1@ip:1.1.1.2".
>   * @len:	string length

This is a rebasing error. Please read your own patches before you send
them, I fixed it

Jason
