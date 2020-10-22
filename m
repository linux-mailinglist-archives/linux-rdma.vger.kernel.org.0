Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4172295D12
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 12:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896858AbgJVK6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 06:58:46 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:43245 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896857AbgJVK6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Oct 2020 06:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603364326; x=1634900326;
  h=from:subject:to:cc:message-id:date:mime-version:
   content-transfer-encoding;
  bh=PezgpjU8kLyAbdt/MFbJHSNVTJGOAevNitk4d074lDs=;
  b=u63uSIlWNVn+Z3nyolkpVO8lHAUGor77BavhI2sLG5g86P6+mcrRo7Pt
   +SLWSdtK7NDFKtu0xpzZnSgpcq+nfA2SxSkcC829BMM3KtwXfNlQy4Q5h
   tVcMhc+CGkEC1WP6C5pZlQuXY+20Eh162+BwLYyIkMVqna9G3FfIhBx8T
   g=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="62659244"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Oct 2020 10:58:40 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id A6899A0715;
        Thu, 22 Oct 2020 10:58:37 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.146) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 10:58:34 +0000
From:   Gal Pressman <galpress@amazon.com>
Subject: New GID query API broke EFA
To:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Message-ID: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
Date:   Thu, 22 Oct 2020 13:58:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.146]
X-ClientProxiedBy: EX13D18UWA003.ant.amazon.com (10.43.160.238) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
API to user space") currently breaks EFA, as ibv_query_gid() no longer works.

The problem is that the IOCTL call checks for:
	if (!rdma_ib_or_roce(ib_dev, port_num))
		return -EOPNOTSUPP;

EFA is neither of these, but it uses GIDs.

Any objections to remove the check? Any other solutions come to mind?

Gal
