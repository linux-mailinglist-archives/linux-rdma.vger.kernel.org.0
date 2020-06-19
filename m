Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C322008BA
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgFSM3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 08:29:37 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:14313
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732219AbgFSM3g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 08:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRbuKx7ObNJbQimEhQsP98v9ic8V6AfOOAy1z6vPHD+vu+OhQaLmxtBx3dlT49cwsfeejzKZw5QYVHmHuBuiJg/3i2elZI8mTeM/zpywAskY0YFj1W2kDop/6lWu7tDAeMzehM03WOAYdfn7AD0+yeBzElKfGNlYNE5kP9/gEmfQGngLXxXDVjI9eqahZCxtzuKtkXx+8CK/OH74T0qL6RjA9M1tUkTnujWLAWJM/XvmlbgKzBNZLhYKcwfpTUZLeG4afAQC4tXn/aPC5W8urZIo0gJxTLhjKN8+QO0qt5dhUlDKNsIxf6lo9bpfujfOBmMGCym3udykuX/1UpMkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTt4TM48ZSTqi6B6aX8RvFyZdR4I+FGwYJXi9NcTCoU=;
 b=GkUcEayCd32QwLz2sfO/KAPPOzOXtF6MxNkLajfHNX2Rp4TZUqeW5ypO9EWrlGdYJW3yBCl7nRJbYduCRVGgf10LNCdOllxe6Y3Lme3QSLsecNEmv8ItwC/Yd216NDIgoDb4QpcLiH+RFqqjPDEawdyTy4CGSSfbJyuy9ECyx+Vk3z+G4ZTMYvNvzqEQ/kBM7oFq09qK36MTwsj9sZ6trz7Lu5p0WRKb41GpXhMKnmnjIbe3nEttHBmqnYOL6vHf16HDbhqkHTeWpKQbu8bgMS4vQbNMAiEq3e40SDhSNmuvMFGVUFi6S7pPi/qRl825cByxZp8cA3oUp3h6RNDGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTt4TM48ZSTqi6B6aX8RvFyZdR4I+FGwYJXi9NcTCoU=;
 b=oEU42P25m1UMvH2efZZyqrTWWEr2HLKUn5kb32It5mnk6W3SYRbocjftkiLvxJu6O9qfmVKxsv8svTn8SU1mh+oYOOJgsiSwHTDpMGU7DusshaAJptgZ0UHFUSHm17E+IrPI6hbiarO7PavWQshQukc0e8p+w2WepnsHnoZ1jug=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4110.eurprd05.prod.outlook.com (2603:10a6:803:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 12:29:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 12:29:32 +0000
Date:   Fri, 19 Jun 2020 09:29:28 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: [PATCH rdma-core 03/13] verbs: Introduce ibv_import_device() verb
Message-ID: <20200619122928.GT65026@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
X-ClientProxiedBy: MN2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:208:1a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 12:29:31 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jmG9A-00AkoH-Ph; Fri, 19 Jun 2020 09:29:28 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a594d0a2-b00c-41b5-554c-08d8144c6b0c
X-MS-TrafficTypeDiagnostic: VI1PR05MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4110BBC1EB83A04576A01C46CF980@VI1PR05MB4110.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu3CrHTP0tnUw6ujNuJ59L8478jF/Xtizvnck993RePRbu/CSjzfkYMyT/pSuB7uAogIggfTUzShrZqBwLiO0ixgoBC/GGNRmhhSQrHhBnKf8UI+zEftzJpm3aNm5rI32oPsbRpqJmRcA9Jb3yRUvj0MnfyUqy8ue+RKrcdiqg+v8ScDFDgUo+4OXWbH5NtsAHOPDcW4hnDosiwOTszCNJctVPRcBKftq47cKxiTF/TAE456q61vrDxsyg1zDMVrXwKhbIkeiTQVCCVCJbqN9uzzD+TziqDtExQHDLs0trzKw9BNqf31dDSK1CayIMrb8kv4FJlTLByrupz2JUmMLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2906002)(26005)(66946007)(66476007)(33656002)(66556008)(186003)(4326008)(37006003)(5660300002)(316002)(107886003)(1076003)(478600001)(426003)(2616005)(6862004)(6636002)(86362001)(8936002)(9786002)(9746002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Qg3gD0C+4uaUO5T3ompUYRDUsB+6GrmCv9kwjxasloTu3UsvGa5V/IN4sg97zqVjBZtJfoizpEh6aYL2AYbXKSLyQcT85AGlNXjJSxI8guF1KflGKkt2kcz1kL3pmSayl8Q9x1pJuWKGWf5gTFUcWH5VS2d19JBXlpEy0MRHQ/bvqL4u30pRQI5YMxvYhwBeEezV16GU8l6TpEU/AYO+xyCiM5x4fwfOaGqseq98qLiW4oHpxxhlHo01r8wLxiYjMa8CBcAbsbGfcck7dye87cCMEJSW9z4t76Dz1rKN2zslqZNxTERkpa7Pm0b8do3HLZPx9xwShQB/5wMfMiZ51FW8askXpd5lXT8vP3AHyS6JsEuJqyXGCX935zhtEmfu+jwfAPjo2ns9b/YSFVv4yvQMMw+DHRfBksFN4USY+DGwZdWyUvzAGYKr9VS2ZVk0fKQePy2P1EZ+C3M5I6Jd3h7sS9jZIXZzia8Y0ElffCU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a594d0a2-b00c-41b5-554c-08d8144c6b0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:29:32.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tWaJoiBtw0nFGDQFLo5YZXLoIHmisD649lDZhqi5n7icFXNRvnKCrRE1D8nS1rsOZsiQTbpA6r6lMaj7cTuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:45:46AM +0300, Yishai Hadas wrote:
> +static struct ibv_context *verbs_import_device(int cmd_fd)
> +{
> +	struct verbs_device *verbs_device = NULL;
> +	struct verbs_context *context_ex;
> +	struct ibv_device **dev_list;
> +	struct ibv_context *ctx = NULL;
> +	struct stat st;
> +	int i;
> +
> +	if (fstat(cmd_fd, &st) || !S_ISCHR(st.st_mode)) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
> +	dev_list = ibv_get_device_list(NULL);
> +	if (!dev_list) {
> +		errno = ENODEV;
> +		return NULL;
> +	}
> +
> +	for (i = 0; dev_list[i]; ++i) {
> +		if (verbs_get_device(dev_list[i])->sysfs->sysfs_cdev ==
> +					st.st_rdev) {
> +			verbs_device = verbs_get_device(dev_list[i]);
> +			break;
> +		}
> +	}

Unfortunately it looks like there is a small race here, the struct
ib_uverbs_file can exist beyond the lifetime of the cdev number - the
uverbs_ida is freed in ib_uverbs_remove_one() and files can still be
open past that point.

I guess we should add a special ioctl to return the driver_id and
match that way?

> +	if (!verbs_device) {
> +		errno = ENODEV;
> +		goto out;
> +	}
> +
> +	if (!verbs_device->ops->import_context) {
> +		errno = EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	context_ex = verbs_device->ops->import_context(&verbs_device->device, cmd_fd);
> +	if (!context_ex)
> +		goto out;
> +
> +	set_lib_ops(context_ex);
> +
> +	ctx = &context_ex->context;
> +out:
> +	ibv_free_device_list(dev_list);
> +	return ctx;
> +}
> +
> +struct ibv_context *ibv_import_device(int cmd_fd)
> +{
> +	return verbs_import_device(cmd_fd);
> +}

Why two functions? No reason for verbs_import_device()..

Jason
