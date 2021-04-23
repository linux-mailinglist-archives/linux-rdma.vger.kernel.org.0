Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4483692D0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Apr 2021 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhDWNPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Apr 2021 09:15:03 -0400
Received: from mail-eopbgr700054.outbound.protection.outlook.com ([40.107.70.54]:12896
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhDWNPD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Apr 2021 09:15:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9lh+JEBRoQcOQbQRnzTk8mBRtfnT6WRp6uXqxFkeDscQTso3g3h62SmETd/wthvS2jnjcc8A9qjsxKZoghJA6kO+I/eK0rsAjQ9qLA8pCOSbroySUVpWBvBx9IkPOWi9g6boOd5tpa9kozCvHmpjl/xKOkav2ICno1Sm/gdAXQBkQQrPX0VSizixv5KpkUjlL05p+pANNHI5NRFjjLRSl7CGIh4PJBMupoPgY4JagFSQpWr/OwUNFgPL4MCByJpR1R79e6WV0DD6kKjSp0szb7QcPMTvw3QRQqYqiMtHcEduvIvOaN+qjMzQTfkejJMWoYIbdpYYGRLZHGbX5SL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK7J+Z8DtJDjF7s7VgnRo23DFcQOG3XftMZtWGO3fms=;
 b=FI7pN+Ts4/LZSF1sSS5T5tyKeGLf+Cxtwmgcug8vgWMmlfhwZj5eosjLGVu1bOf29RWFtkQ3Yklr2QndHORrs9Q6VlYd7GP3xY2iScJMWW5K25wu0dBXjOY6AKM3PdoeM41UsXxeoMnZZAbWa9HzWeaWyF7Unvchjujdf4E2RjmJhtPGn2z1cTJL7q0t0Y1wWaiP7CNlr+ZSFCevPp6FHUxDjx2WihR+REp19880R5PxRSW8/nazfUpGY/bblQlnFIjLRRNcsdZJDFVJ714RT1cmYSjchrMiUFbwdlRlXY/OCzHSffUT42ONE4vdhpvJIw5pLAnDbosBCj6Zojoxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK7J+Z8DtJDjF7s7VgnRo23DFcQOG3XftMZtWGO3fms=;
 b=YDPjlpKZih5+/AehDPZ2Xxqqo6xIjXUAFGsdv8fpi9zCpohcrXwnwLMPmc36GT8PBvZmnEwE9nSXdGqbSkG9LvBbBAPDhiMVQSQ62r9oRac1Wshjk9W4pN5FDvLcYl4ciKnB3LWhxQ9D+0eRJ3pJENohWj6hF+t2akUkMPtI0BDFGBf7yh00b9pqYEA1VT8aQ+mNEv7aAFIfxDcEqqSD4A7FOvTLzu7YURMeeyAL1AgOU5MfaSymL/at/t6fXcd5UVzplxFxDjc7cKGOjcOVEMCpyyxR7hfgM4Jtsq8aIuKvLl4HgECKJlgjmphhjIque+vYcd6fHdSdqSBNLkfupA==
Received: from DM5PR10CA0021.namprd10.prod.outlook.com (2603:10b6:4:2::31) by
 BYAPR12MB4616.namprd12.prod.outlook.com (2603:10b6:a03:a2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Fri, 23 Apr 2021 13:14:25 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::2) by DM5PR10CA0021.outlook.office365.com
 (2603:10b6:4:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 13:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 13:14:25 +0000
Received: from [172.27.8.107] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 13:14:23 +0000
Subject: Re: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports
 when remove a cm device
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <cover.1619004798.git.leonro@nvidia.com>
 <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
 <20210422193417.GA2435405@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <2eee42c7-04aa-eea1-f8a1-debf700ad0b0@nvidia.com>
Date:   Fri, 23 Apr 2021 21:14:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422193417.GA2435405@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a61f56-8266-4737-01aa-08d90659b7b1
X-MS-TrafficTypeDiagnostic: BYAPR12MB4616:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4616E8EA39399BFA594D39D8C7459@BYAPR12MB4616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3ipMTElq7FtX/KoXxC8n2u0mk4NDokRlNq6n/nPMWl94usLBO9eZej8SAxJGKGTCeDm0hP1rfLmPCCp6kwuCEpWmL2IwbtxjNqqItg+jfiH+p64+beOamZ6aHYhP59guEi+cZ34kQpr+l1cSAcvwKSZoKrPZ3fdtdeqrzmp2V3rHxTfWJ2Iqy86L1qqyb/AsbwxtUKr/K7FJMWd9EIswZSOr0Fsu2WR3qi3hgaV6NEUoONZZPC7exk4tiAaLZrdWiZOKA84iaglXAL8JE7Q3zDzF1P5ELK1hUIcchsjH8V1XQ0awPU+7JIXMLmkaYtry0uy6MhkmiWvRKalTvL9ZK6wbr+MBv5kITgO8hWdozEarFi4f8jWNdjghXY9utOmU6K1QLNzTA/8BMP7ureS6OoQCOOKmKpH7N/l7jdlvCZ/1mUd7bnZ79qdD+KlYEjptl38OOwtz9LWlF5eZFjY8T8XMLTpdK1qfhvXJPMnyhGcIWDsGhJHd63qqYSl3g4NbkDDKQ7p5jfhncXnFmaLbgN7RdvxH4cTVJRPIXopDtEkx28maSzlUIjxNXa1TvDlNCoPqZzCNegssK2w+SihJmFbal9It7iSSqhjJ4KNY1UEAe+EvU8uC7Ezq8F8H2RzHBt5hPjt116YAFBa7I9r/6MUENx+xNOnoeewjRlS835tn2ZVDBtyXadUMlXBb72h
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(36840700001)(46966006)(186003)(70586007)(2906002)(26005)(8676002)(426003)(5660300002)(31686004)(31696002)(8936002)(70206006)(53546011)(16526019)(47076005)(4326008)(36756003)(16576012)(36860700001)(36906005)(82740400003)(336012)(478600001)(110136005)(54906003)(86362001)(2616005)(83380400001)(316002)(7636003)(82310400003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 13:14:25.2163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a61f56-8266-4737-01aa-08d90659b7b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4616
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/23/2021 3:34 AM, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:40:37PM +0300, Leon Romanovsky wrote:
>> @@ -4396,6 +4439,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>>   	cm_dev->going_down = 1;
>>   	spin_unlock_irq(&cm.lock);
>>   
>> +	list_for_each_entry_safe(cm_id_priv, tmp,
>> +				 &cm_dev->cm_id_priv_list, cm_dev_list) {
>> +		if (!list_empty(&cm_id_priv->cm_dev_list))
>> +			list_del(&cm_id_priv->cm_dev_list);
>> +		cm_id_priv->av.port = NULL;
>> +		cm_id_priv->alt_av.port = NULL;
>> +	}
> 
> Ugh, this is in the wrong order, it has to be after the work queue
> flush..
> 
> Hurm, I didn't see an easy way to fix it up, but I did think of a much
> better design!
> 
> Generally speaking all we need is the memory of the cm_dev and port to
> remain active, we don't need to block or fence with cm_remove_one(),
> so just stick a memory kref on this thing and keep the memory. The
> only things that needs to seralize with cm_remove_one() are on the
> workqueue or take a spinlock (eg because they touch mad_agent)
> 
> Try this, I didn't finish every detail, applies on top of your series,
> but you'll need to reflow it into new commits:

Thanks Jason, I think we still need a rwlock to protect "av->port"? It 
is modified and cleared by cm_set_av_port() and read in many places.


