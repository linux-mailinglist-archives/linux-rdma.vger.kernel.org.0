Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA21F9E8C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFORcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 13:32:35 -0400
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:38821 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731183AbgFORcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jun 2020 13:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592242354; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=a1qPeJnsgR5d6Xf2FeiK+qLxCdL2WXC40YTXT8A9hy9X+YRUkqNtQBo3aI2GWCpg6EkHz6MG61bCMUh+iwjMPDq7Tlx22WIOwZ9II76tEfUTd2S95p0gScShqw9d/sPw8j0dV+swHMzMPS/PE/WqeuTAKQB75rK7N1Q0LiV1/+UphRVXkG+iIWZkdnCdlFPc6wOW2WGt8AB+E/5DMELOtXqnd4ocNtzRZ2k76VzTtAojFE7/oT7O6EsCtP+G56+8K69t5fwAcTX765BoCYuy1qEVdFfbUh4i9YmS6J6Tbbc6gl62mbmfZn8e7znWax0mLgKepOuAgrFBPKFkyfnS8Q==
X-YMail-OSG: AjE6pkEVM1kNHBgCKC6tIuRaPfOX9h2SF7fkvjvAmN8bkpnIVLOkLZUc0LfLfr9
 bRNvuL3DCjpbasAw8jkZ0q1sr_SxgQ5L4_NKII2.ymXI2dWo.kVwcpmn.dyCCn_LceW5GcDgNjoa
 XIayuBMHhbwoPQJX3XeWEJaHvvU3fcykcu_zG_tL9QYtJa9weHhGd9hUrI0zgL7tF70mpbRabS2W
 8EHmstrQOc037EkiYAKhWThI4lZtVT.46AZ_bcrv_MZc8pZopnqwOaZgq2P2boPWdQ14XlBfbQsx
 bf4YCxBxZJCsuzEJzJLv8ZXMu.ncmDBOnntP_73sr61kvAD.LygezY8LynMAahcH8C1bXON8CipZ
 wgTDqlUXrFNRcmrc5SFJHnxf.N4OPsCwt.s4w_gBAdynQ8bwydqSv8nxqU1TnJpe4LREs51Djz2R
 4ckdJMOiZO5amNqxWz.2_h61grILpfC.CmtJv9Ws.0iU9mfU98q8FCtwxBV2Jq.w9seSofrONecj
 5dB1OKbhRalJFNPnihJSOl8X08dKEtE6v8yh.SaLkVyelte7EP24xFn9xmK5MyTqUC4MEmuh5ty1
 sJAxGLkPTSufPR5v.Y3vD.gtxyrnrzTBV8UD1H2H3ul8l.s2yZrUuBK_79c8I3SpUEIlh8xCo3rQ
 ifES63ImS1QAkspkrHAK91WXkOEjAsOBQAAda8C7RroAzw6C94RRD4LTSPOG8BGHw6D5XPAXp8mF
 c8nBzcyzlbFdgGRjgD90PfkMJxUKqNpU8Typb7_SiBWBxAsHiu4AkLI3wfOsGPvex7pNJZvjF8m3
 rFeEAqeb0vJsRHR6Xn3pUgRRTw2f0lUsZi.UpTsWamlmJhmvG9hnd_a4OOrx4EuwELV7plZOwVRN
 61Eh7K8o3JNN7LwQrrPzOTQysXGLewaopus2gcBPIuq6aBLzeU8s5CLzl4W0JDfY_ZXo5XIQdjRz
 8VfpK26_gLDvcFrAeKv0WQvoCzebSh6mltu2CCnSHjgc3i9OQ9MtkwVYecPku__axSMYJmBELK8g
 npGNZBmuc7hJQ2JF_DHAM9weFvqPHEnEyT7ITwVK6qoyDBdgPKEERhFTQS3wJ_CiUpXWHR5aCEJv
 lFSRc8ihpWjejG1BraRpDp77GybrfXfqJZ2Hu2JKZj2zpeEt0DzhJaj2XaEwlEyVLS7EOZw0HdG8
 9TNiVnnoZuBA_1giiIpqwti3dkmNZYH1w5jIrNq9zBuLCWpl76AwO5a2qxGkQ3qpyjnC5oi8Ue2Q
 wE624C45621PL38mw0JeDw9LRzzKWuPLIEX4GNMtgmQM1RHnRYwJrI9Vxgp6crUA9g1w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 15 Jun 2020 17:32:34 +0000
Date:   Mon, 15 Jun 2020 17:32:33 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1271891906.798134.1592242353602@mail.yahoo.com>
Subject: BUSINESS FROM(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1271891906.798134.1592242353602.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
