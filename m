Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262BDFDF32
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfKONo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 08:44:56 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.104.110]:29829 "HELO
        aliyun-sdnproxy-3.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1727476AbfKONoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Nov 2019 08:44:55 -0500
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 08:44:53 EST
Received: from [10.0.2.15] (unknown [115.196.142.162])
        by mail-app3 (Coremail) with SMTP id cC_KCgCnCvmQp85dxj_4AQ--.255S3;
        Fri, 15 Nov 2019 21:26:40 +0800 (CST)
To:     linux-rdma@vger.kernel.org
From:   QWang <3100102071@zju.edu.cn>
Subject: Why our soft-RoCE throughput is quite low compared with TCP
Message-ID: <f97b72b6-4def-2970-c9f6-f11b97d5378e@zju.edu.cn>
Date:   Fri, 15 Nov 2019 21:26:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cC_KCgCnCvmQp85dxj_4AQ--.255S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Ww18trW7Aw4DAw1rXrb_yoW8Xry5pF
        yrAryqyFyqyF1ktw42yw48ZaykX39Yy3y5Jw17CFZ8uFs8CrWjvr9av34Y9w1UGrsakr4j
        yr1q9rZ8ZF97ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
        82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
        Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0
        xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07j30edUUUUU=
X-CM-SenderInfo: qtrqiiyqsqlio62m3hxhgxhubq/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear experts on RDMA,
       We are sorry to disturb you. Because of a project, we need to 
integrate soft-RoCE in our system. However ,we are very confused by our 
soft-RoCE throughput results, which are quite low compared with TCP 
throughput. The throughput of soft-RoCE in our tests measured by 
ib_send_bw and ib_read_bw is only 2 Gbps (the net link bandwidth is 100 
Gbps and the two Xeon E5 servers with Mellanox ConnectX-4 cards are 
connected via back-to-back, the OS is ubuntu16.04 with kernel 
4.15.0-041500-generic). The throughput of hard-RoCE and TCP are normal, 
which are 100 Gbps and 20 Gbps, respectively. But in the figure 6 in the 
attached paper "A Performance Comparison of Container Networking 
Alternatives", the throughput of soft-RoCE can be up to 23 Gbps.  In our 
tests, we get the open-source soft-RoCE from github in 
https://github.com/linux-rdma. Do you know how can we get such high 
bandwidth? Do we need to configure some OS system settings?
       We find that in 2017, someone finds the same problem and he posts 
all his detailed results on 
https://bugzilla.kernel.org/show_bug.cgi?id=190951   . But it remains 
unsolved. His results are nearly the same with our's. For simplicity,  
we do not post our results in this email. You can get very detailed 
information in the web page listed above.
       We are very confused by our results. We will very appreciate it 
if we can receive your early reply. Best wishes,
Wang Qi

