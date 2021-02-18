Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361FE31E8AD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBRKS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 05:18:58 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3285 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhBRJOr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613639687; x=1645175687;
  h=from:subject:to:message-id:date:mime-version:
   content-transfer-encoding;
  bh=4RubAaQ1E+KV+QuTWj1H/R6yiH5PU4XrChvjPS/sLPw=;
  b=OJFfsL7xSDThhgyQGDuhFOVAddaq3jMTGzsKY3fZuBfDSp76JnQHrpXo
   uT23pQNqZCYvZ1gZiw7Td90gmTsZ10Q9UOMpQiEkZvrhN984fR9boOHQQ
   imIdb6n4PlcXeFXSALhwbbGgMy2Qm2eDqwjSdyyXlkzhERVIwm7M1Tomt
   c=;
X-IronPort-AV: E=Sophos;i="5.81,186,1610409600"; 
   d="scan'208";a="87501376"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 18 Feb 2021 09:13:52 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id A2257A1FEB
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 09:13:51 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.146) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 18 Feb 2021 09:13:48 +0000
From:   Gal Pressman <galpress@amazon.com>
Subject: ibv_req_notify_cq clarification
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Message-ID: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
Date:   Thu, 18 Feb 2021 11:13:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.146]
X-ClientProxiedBy: EX13D06UWA001.ant.amazon.com (10.43.160.220) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
"Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
added to the completion channel associated with the CQ."

What is considered a new CQE in this case?
The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
by the user's poll cq?
Or any new CQE from the device's perspective?

For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
completions, but the user hasn't polled his CQ yet, when should he be notified?
On the 101 completion or immediately (since there are completions waiting on the
CQ)?

Thanks!
