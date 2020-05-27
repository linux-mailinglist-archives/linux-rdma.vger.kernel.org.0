Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCE1E4265
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgE0Me7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 08:34:59 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3222 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgE0Me5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 08:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590582897; x=1622118897;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=H2Nvc/yJHhGZYjOTWL8EGzx1+8PhqJP78/RMMhVgfQA=;
  b=JXUsyKNjkth8lmg58G/DjBn05Im/XcW0kPU6CVP1drs2odlITnceQ15k
   JR3cld/cV/KdGGtfd9j9r9Q598axrYGJU6rrbxDynwf+aJ8tcA9ctIJYV
   iem6wFn347kazCiU4F8QqHcCWjdlHttV4m1yfqhQOPBCoHLD8quOnF+vz
   0=;
IronPort-SDR: LFHZmTxqP6ZrIp2BwYY+Id/VPtiV8rtJqal4TIbhD3KQR5dxgDb5VyC06SK/uLtl1TT7qpS31X
 ZGJUveJdPY1Q==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="32423316"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 May 2020 12:34:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 53A1FA214B;
        Wed, 27 May 2020 12:34:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 12:34:42 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.253) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 12:34:39 +0000
To:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Subject: Issue in "Introduce create/destroy QP commands over ioctl"?
Message-ID: <948a84a4-a8f7-5554-111a-4b191ed0344b@amazon.com>
Date:   Wed, 27 May 2020 15:34:33 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

The recent transition of create/destroy QP commands to ioctl broke the EFA
provider in [1].
With the new ioctl the 'ibv_resp' part of the response is all zero'd, opposed to
the write method.

Any idea what went wrong? Is that an intended change?

Thanks,
Gal

[1]
https://github.com/linux-rdma/rdma-core/blob/a02ba0449c1409742261d68bd251fe0ad0662b15/providers/efa/verbs.c#L562
