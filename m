Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFC286C72
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgJHBmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 21:42:31 -0400
Received: from sonic305-37.consmr.mail.bf2.yahoo.com ([74.6.133.236]:33026
        "EHLO sonic305-37.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728008AbgJHBma (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 21:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602121349; bh=KhejUjG+aIFEdaJtUCWO7uMjCXcLLdLXH7PJ9JLxOyc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mxTCY5u8dojIAoEK7dRRm3e8tg6fQX6p/BSFuCqeFD97orLo/FdEqaUL+Vgv68beRODtWE6heUs3t3B+iCrdkPZy28wUTgEdThl6fQfvPy7Cmjj45R2nqHRz4orr0o5lzILlm7SxT8t/JnS3FFGcXXVml/PsbkAU/grwW0DsmgF/+JX4CKAX/MHjB1Z/Fc6+tETC7+C3bkApWT3CWMvzwZzcrEkjnmCXfDaKgyz2MmhjzZJcAmLTLRucb8uOv6LA5ilSkiI59v8EyKxo9ikH1ok/VFF+PwsHy5ZM/ZrKelzlpDNaHUHtAbnAx10XQk94QLBWkHx84PZc/UAfQz4kYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602121349; bh=uqDj2VPrKPT25U9T/+fYHyMjjjh3wcJG6jaJ8gvI7Ws=; h=Date:From:Subject; b=JtBSkhoMJzEvWPM48YC1y17q1Cw6lQAEqD4glqgpMbIQ4lSWeupmtDnE9H7mo3uK2gA9VbTzpNk/F51uZ8j4QC0Y92g4a8xzM261RpFFZIsCRnIkWqNWR+HXXV5uHffTmbSDD1SczHuyG5LuHu8M4uCR6Ot+4k36nK/iQjFKKTdPzvpZNkRjSf9z1izmXmdO9UJbmGsv+vUMSiBjXR2R1k5IDm4pF0cC/f5dU45qJ21lJqE3nnbXftaPdT7xR2/CoMv4tD9mcvFpuHD6hIh6+ifDkEurvBudyLEn29nRThkIYO9Hzc+hEI/GB0EjNZb3WlZpNB3WwXWmoEbzOK7wyw==
X-YMail-OSG: UTHzd1gVM1kUOprq2E7c7l7h8ZbDBFFCByblZ4goQS9jWtmdXfMcT6U_Ox7H4Ds
 X52X6Hqp.i0BTg0dcEHbfnVwE7EPDJT0shydaqCdNkKCKLcop0J5BEe8W7R1hNrjO6IZBic.Ty0e
 Vi2utWyLe8OW3rwC2BixdqwpybZ0pOGqkfpnO7feQDYlZ.MuzlxL0xKB92uI7d5sI1pcKFanYbJH
 _v_tOo51CKqUQvJkYfdxsJNNSTWN6dfyBkWIVXKLQZN4rxhgVMtUeJMXl2LeWZ2a78uaXLmXL776
 UPo72i7127qvJDkDo5hPtUPPJt_TbspsHmuHddiJwmEqpip1TMfAah2ZfFakY0_rgcW9AFFKrTMl
 QHKytwHq632bmejes29GXqabaTUWEQ99V_K79z3zeBrWXnvGeV3u9KQevsBuL3Ci3g9AwLYvLz7s
 jH1j59q8Y6y5CjsHo2.ylfnaQRqh4E2mJLH4A8EoDMHXlcB8.2RTUj3LnqeYkVGxkHftR2gcMIwk
 mm51HDr4h9z6z8zqSTLK0FwuYhWVU1BVHsOeFTfVR9S.gIW8G..C49x35u6WgBNV6WMYzHKvZqzQ
 7Supxu4WVexoenT9Es5ae3wMuBwSZchSyWX9TxOlWaooazNNkWTiJnZ4pQGcXpl.ZSEDJ8AwejMv
 g14ZUbqVkHdxAiGBOdFdC51JgqgzwfoodHwWF53UkoBTG_XxedDarMuTfx2b5r3vzlJIPxFx5iMQ
 b7zwi6iRKgNOblRDKdttHGlpZAcayXXC.E55z8Wf0oplY_acn4IgN_oYaYkenNx_iD8e5BlO5FI_
 FHn1KoSfR24.y1JswUl_X8KXzqMKBJ1nQ.HiTli75cqpRbNIbUtCNfTdvbJES4iwVPrLPAyupyFw
 KJGPy00fIyKDyxj_ALsuei1cy7PhEkLOBwK2a5emJw7flzrRqV54WKWX3HaZOJzoerLjVPKLNVuV
 CEwCe86d4FF.pgZI0jPMmOh6v0cK1fD8MoMNdiyDI7rs9W8DFl1yerEi9kDJpuEw1mqIZozZfWfp
 4BGAfmt29jYZ2bKSpc2gRiZjBQ_3DmvVDRRa1FvM8GKWv4uubkIZpPr9UFnkpJqi3vr0X2E5F7W5
 EFgWkGbuuNNz2REdFabs3IDmlf9f7udTWB0PNgSls8sKxapX01i0HKI3C9vPZbmRT8lYrUToPm9T
 Zzip2GLrebwroSMpXkLZJFtkISpZwgqKa1_nUuP2uxx0Pma_ZNYUnKCBIrxHPgajlakK_m71Cunt
 2X8xe4ORYjEzj0rJXU2YDyW2jay5hpCwpXGHMoVCR8bwzEcqtVIZ7tmqgnMJG9y1sHSClGF5G1AT
 8eE.ScH4cCKAKKiTxvJE2RQsGvAm9zpEZTrOOyHtKhni7mWP3AdgANxal6OvRvxL87wVgsstADZ0
 Q6D3TndATmhtW.vJ7nRkjDtyTloWdIW2LGR68ORCtLbk0Ff_N6cWlqPswla8YWDgfP2X3YwfUzGq
 y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 8 Oct 2020 01:42:29 +0000
Date:   Thu, 8 Oct 2020 01:40:25 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau9@fdco.in>
Reply-To: maurhinck4@gmail.com
Message-ID: <2103559524.308380.1602121225814@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2103559524.308380.1602121225814.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck4@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
