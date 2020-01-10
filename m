Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73258136B90
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 11:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgAJK6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 05:58:46 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52149
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727598AbgAJK6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jan 2020 05:58:45 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 05:58:44 EST
Received: from [192.168.43.114] (unknown [223.104.212.70])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnqlw7VxheS8whAA--.49199S3;
        Fri, 10 Jan 2020 18:51:41 +0800 (CST)
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
From:   wangqi <3100102071@zju.edu.cn>
Subject: [Discussion] can ROCE protocol work with NAT (Network Address
 Translation)?
Message-ID: <c663da6a-486e-415e-0687-300239f0f56a@zju.edu.cn>
Date:   Fri, 10 Jan 2020 18:51:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cC_KCgBnqlw7VxheS8whAA--.49199S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUCryfuFyrCF1xKr15Jwb_yoWxZrXEva
        s7Xryv9F18Zws8JF1UJrsakFW0q3Z7Kr1rKrW0qryUWw1DtF93ur90qrn09F4rWFWFgr1f
        W3WIqFWrGwsrZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
        cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
        0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0S
        jxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjxU4oUDDUUUU
X-CM-SenderInfo: qtrqiiyqsqlio62m3hxhgxhubq/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear experts,

    Because of a project, we need to use ROCE to send data from

region A to region B. A and B are not in a same LAN, and it will

go through NAT (Network Address Translation). However, we found

that we can't send data successfully. We do some investigations

and find that in an INTEL ppt, it says because "ICRC doesn't allow

IP header modifications", ROCE protocol can't work with NAT

while iWARP can work with NAT. We want to ask a few questions.

1. Can ROCE protocol work with NAT? Is the INTEL ppt right?

2. Is there any method that we can use to make ROCE work with

NAT? For example, can we modify or remove the ICRC part in the

ROCE protocol? Is it a good idea?

Best wishes,

Qi


