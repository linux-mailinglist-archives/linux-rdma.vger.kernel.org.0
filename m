Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692BA174C55
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgCAIwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Mar 2020 03:52:35 -0500
Received: from sonic313-4.consmr.mail.ne1.yahoo.com ([66.163.185.123]:39300
        "EHLO sonic313-4.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgCAIwf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Mar 2020 03:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583052754; bh=VxFSqOLnoyhxZXWK73TPGK3hr8yutZ4yWmLQa/jSY/I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=VAIwYKGm6kdLrZgMxX+h51yqgzLdH9deXeQ+gPgsTw0BCI2OuQ+R1bMk7kf2ZvN7LJbxEsl09aolqr1a7kipH5BLP/yr5+fI6dGivnvRBgaHW13Q5Ec/qCZKbzATPq9kuyBfI9QS4OXgHTFreUEA/jSs4SgTyif6bTL3X4Z5wQqzeFAwiMlFwaRCBHHj0et0TWKa3foBtiYOzIZj9rC8oxlaLOttrPZUe9Sjd5GTa+bYAz0a0Q6D+028J5dDZ5YExvVwF4bIjToNwWjnmteGcvnav5luGEBy81kwvrH7ySZKUGdHN1zqEIaK7yr0Uhh+dJBZNl2W86jW1JKq6u0xmw==
X-YMail-OSG: CEfI7Q4VM1lK5aJXRvKsXiFAGKOZtEb6YZdofItRTk7.3fNxItd_HRWAIp1mLCI
 gM_8jSOdM7qv.f8wv9EHu5xMLa8Sd15jiWIeopXEhU0Ckv5C8EwDvSnfG15qHrcUfnEa.rY.GO1H
 CBKbPySaoiSS66.Z4QNEM8cBL3gKd04ahQMB3ATCo02lBd10R4TIJ1Mi3bEqWlWkdMpMgUtI40Oe
 fVxTdR2EIvUM9ab3XylQGFpTPiwbgxyzB0YYBpkDA1oqKq7a8YnH3XaP8t.fP_fpNFKtxrCS30R2
 pgfG.d88vYE92PXxL7CcPQMVgSkG39Sf4Zhis1C671pXZcPeEKUH3GIuusloPbw1MZYYnU2pJXo5
 5Krhx8CSk2.B78nVTIf8WCHzf4j9.m_rfVJsIT_dUxf5f5b5THm0mUzeC.7khXfS7YfQnxeKdoOQ
 u72dpKNrAWIIOSQ5rhaDgpFLa6BT7C9pZcG18ijCK5rVNVsB7CJXWmJ5HZz4s.HBDlRxreldq2Fu
 P5gfa2mqS99KZyEli1BIrRJ.9SIEiqLDPsGLBLRzgmjBlGX.aEgF7USc_2NQjmLUt7mnTxMi33rR
 qHfZ7LCrLJTZ1vi0Mwmud7g3HOUoXy7NnOfyr2EfeXydmECmqoy7AQ0Cjd2P3eTklfO4.cZJnE5X
 8cuoFatcOpiid1dVSPaJkyrYIQWOJxgL08ej9awp5u3Qk67hzN3YLNDtpzJe0cRCLkjWAkBZvcq3
 aV6.ZaXdYdmq0FAvjgeY.LJtLia.T5jdn9m9EPjK_MjGVaD6wa48cCUlbxDuxVkH148EIzhMF2p4
 Fr1pLsz92_GZfFhBLBsVqroRu3L5KD.PzLzurGEfMUmFi3VVhikD4gS0uKuuL8KfxNE910V613mB
 Qg7t3WBC3Qjl8MUJ2H0G.ZOWrUybK6pOLYk8KSnF0kX0Ur0TaO_F4mtQKQcjp7HA1Dk3sskeL0Vy
 3JD3sebKyH_i7piU8erAKgIXIJszxSR9f.fhWtGE4lSnzlRrvrfsVMksWvdJQLYcrNDTPItlkJzM
 hdDrLGrOKZykFBr54j.axgpYFek_GZtPzSb2z0VbLmFs.fi1.v855wRncpAWGYvv8WNuBxqyUMGf
 KgeplQgxgowiQcsm2B6gFlxIPxKaou87LenyvOHtP4mpHkwP7UJwepBpR8jFUicKU_CW8F4XJjkc
 NrZgDaVo_twbEqNGOONnC4n5YU0voeTcPYlWJNiDZDpcfT1AF8.QOZyCzdGqIm7ACBMNhYO6P7oQ
 c_XGuPe7lz3agcmTHDlyS1tGcMnQUizTycOuQ0cRogo_Ft3hFGH9uIhwxj_HN3oYJMJMt5Jr.hDv
 1DIpZ7H78d34Av6Y4KlD1KI9EsymI6vo2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sun, 1 Mar 2020 08:52:34 +0000
Date:   Sun, 1 Mar 2020 08:50:33 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <gg14@gijimaz.com>
Reply-To: maurhinck6@gmail.com
Message-ID: <1249045932.2536284.1583052633817@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1249045932.2536284.1583052633817.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck6@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
