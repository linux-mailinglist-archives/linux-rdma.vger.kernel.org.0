Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988D3D1FC3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfJJEph (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:45:37 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:4024 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfJJEpg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 00:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570682737; x=1602218737;
  h=mime-version:from:date:message-id:subject:to;
  bh=+Ge6RQ5EEbk2NFp4KXFfiQFXMowpb4uMY3rL+1ZBbVc=;
  b=cspYgve08Cs3OvAENJG0VVX/ZGgKqqM8cT64MUbqe46ykmrhJJk1CIC5
   tuZC4mrxTUmmemNXqtsaLsv9COl4eIjxoqtiTEUo6vr5dVaA+a+IbdNog
   FUwhPJFfQ/iXMr7/Ho6UxwX1DC0WNuR1MOyYBZjFj0uBD8XD6uGy9gYC4
   xlFHNzbbX+biKv6FWyA6kfwZEHHkIk8cHDJZCjUcjDN46FNSq3Zry3A9x
   7r7M9nQCvJmwDHdEHdl3xbw8yOPbs4xv11mXwzuvpVkGjVo6me6NCgRra
   ocn1uUlJUOYdwsuHV+3UfUqR1Uk+tCse35J+72Ju98lArCa0Voj9KYiRT
   A==;
IronPort-SDR: cMdTLMPraB7tYBcxRr4Vr0dRAHdfkfQV0VXYUFRCFs7PBHA1xEE4GlcnEIwOumHi7FGbJ9pHAk
 Ejg8puVhISzrD8GKCI5pOTJ8Jdw6bfKE2vdxPZ1hqpS30u+X69vTmb7Bl9wZPWD0OLTMoEMpn/
 KqEBsonaonUWaWLnDWdt2aUKy6n2WyQScJa3oEoyoAKmAToUbaqAJen3LlrJbUJLKIPjOH+b3x
 wBtnc559IrjgIRLJKzHovb/+96xLpFk/skud12D/MHdBKFjkhco1iDuOLhDSyob4bZv8ILSOr5
 6/M=
IronPort-PHdr: =?us-ascii?q?9a23=3AGTxBBhKo+RFUJCC1PtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfL/nxwZ3uMQTl6Ol3ixeRBMOHsqkC1bCd4/CocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalzIRmoognctcobipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6zYIsBAeQCM+hFsYfyu0ADrQeiCQS2GO/j1iNEi33w0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4Et0MsXTVrdX1NLoVUeuoz6bIzS/Mb/JL0jr66InJcxAhruuNXb?=
 =?us-ascii?q?5sbcbcx1IiFx7ZgVWKs4DqIS6a1vkUvmWd8uFuVvqvhnY5pw1tpjWj3MQhh4?=
 =?us-ascii?q?nTio4Iy13J9z91zYQoKdC+VUV1e8SrEIFKuCGfL4Z2R8QiTHx2tysi0b0GvI?=
 =?us-ascii?q?K7fDANyJQ62x7Tc/yHfJaM4hLkTOuRJC13hHNheL6mgxay/1WsxvTyVsS2zV?=
 =?us-ascii?q?pGtCVFkt7LtnAC0xzc9NKLRed6/kekwTqP1gbT5f9YIU0si6bXN5oszqQzm5?=
 =?us-ascii?q?cTq0jPAy77lUfsgKKUa0ko4u2o5P7mYrXiqJ+cLYh0igTmP6Uum82/Af43Mg?=
 =?us-ascii?q?kSU2SH9+mxz6Dj8lHjQLlQkPI5j7TZvIjAJcsHvq65HxNV0oE75ha7Djem1s?=
 =?us-ascii?q?kYnHYeIFJfZR2HipLmNkrQIPD3E/i/mU6gkDR1yPDcOL3uHJHNImLEkLf7cr?=
 =?us-ascii?q?Yuo3JbnS80y9EX3JJTF7hJdPf0XE7qnNnVChswNQukhe3gDYM5nq8ZRG3HJq?=
 =?us-ascii?q?KVPqTIvRfc6uYiL+eLfoM9ojvxK/E5ofXpiCl90X0UZq6vlbQKbmy4Ge5+Lg?=
 =?us-ascii?q?3NY3XjqsUAHH8H+AE3GqiijFyETC4WfXq3Vooi6TwhToGrF4HOQsaqmrPFlC?=
 =?us-ascii?q?O6GIBGI2NLEFaBFV/2eIieHfQBciSfJolmiDNAHYqhSp4801mXtQb8g+51Lu?=
 =?us-ascii?q?vF5ysBnZn4ksV+/avemQxksXRfD8mb3HCQB1pzmGxAEzQt26ZwiUdmjEqIy+?=
 =?us-ascii?q?51j+EORvJJ4PYcYwYoNYPbh956AtG6DhPTft6IEA79asitG3c8Qs9nkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXTXJE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAwAmt55dh0enVdFlDoZEhE2OW4U?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHFCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCm?=
 =?us-ascii?q?FQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCeAWkQoEDPIsmgTKEDAGEWAEJDYF?=
 =?us-ascii?q?IEnoojA6CF4ERgmSIPoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZl?=
 =?us-ascii?q?PDyOBRoF7MxolfwZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IPAS-Result: =?us-ascii?q?A2FRAwAmt55dh0enVdFlDoZEhE2OW4UXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHFCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6KQGDVRF8D?=
 =?us-ascii?q?wImAiQSAQUBIgE0gwCCeAWkQoEDPIsmgTKEDAGEWAEJDYFIEnoojA6CF4ERg?=
 =?us-ascii?q?mSIPoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF7Mxolf?=
 =?us-ascii?q?wZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81371734"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 21:45:26 -0700
Received: by mail-lf1-f71.google.com with SMTP id c83so1042157lfg.8
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 21:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V6cjM2qh3lyKS09CLhQGgKKcyIxkLzht81qjdvHNaNU=;
        b=HOY9Ce6aFtPbLxvIaUdZTjY04xTFMX/168EmzME52DIrY3AGENCXSCw2YxcJnbOGVO
         EUO0hHo+Cqwj7HQncw3IcFURARZRQH2+cHJNoHr7PlTfOjjM2tOTOyA8iW6tRorJRWrA
         XMXVSzn2qKrziNtYpwlaqg2m/9j24c4vCZGmsV3YeOfDKTLceZDj13VfWircSdSoycGM
         FU/rBEl+Qyv+gRqtw72hUqDI/d93oZ3AQ5Nw03F3BHvWxvKvEO4UnkKtjFb+3XUQmzrM
         cgNdfC2LvvyzucnvCCS+M6Ms/QqdfPc9+r4a6lP6pBk3tNvj9P80G/T6t90+EpKLLLDP
         7yrw==
X-Gm-Message-State: APjAAAUllVqUYRxocPL10PnZpQ9xIkmyxdZXDmBaAwMcXD8JoeVzNqCD
        hUAr1aCVMzZ4m0UoX6IhfcQHPuwpJPT16qQ8VEf6hL+ZMiwL0wKMBHht8AUQchajfTLHqLO3Lcw
        EH5plF1heffZcUKHD+eGODheuqA5/O2nQbFH0jss=
X-Received: by 2002:ac2:4845:: with SMTP id 5mr4293570lfy.191.1570682724789;
        Wed, 09 Oct 2019 21:45:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1x9AZgLV+61XMXXlIC+oLuJtWCWzXpz8VHNyPNzHXul+5fsFjuz78wD6ofpSibIsZLzZdbbAZUx6k7PFAKRM=
X-Received: by 2002:ac2:4845:: with SMTP id 5mr4293560lfy.191.1570682724585;
 Wed, 09 Oct 2019 21:45:24 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 21:44:58 -0700
Message-ID: <CABvMjLTZ3ztSR6XkHa94iLTnHDK3-P3wRo+31UdivSMavzeq4g@mail.gmail.com>
Subject: Potential NULL pointer deference in RDMA
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All:
drivers/infiniband/sw/rxe/rxe_verbs.c:
The function to_rdev() could return NULL, but no caller in this file
checks the return value but directly dereference them, which seems
potentially unsafe. Callers include rxe_query_device(),
rxe_query_port(), rxe_query_pkey(), etc.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
