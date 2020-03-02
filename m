Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBB175D74
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCBOnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:43:07 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35279 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBOnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 09:43:07 -0500
Received: by mail-pl1-f173.google.com with SMTP id g6so4284247plt.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 06:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=+RqTSQ+NT74k/oC1T8Nb5e8kb0y4gxE44JjVwpeMXDc=;
        b=bK2rQ96ch97GQ4JNHpPvYgiH0KKWRigpa+RSflt4gQYS2zgd7FFJOCINQf4WYcOJa2
         fq/cLjaYL3DNG4Zat9IRpAd0ep4aGChggrMHIAR2njV6PNaOJnX6vIx/Mhq9Pc5a/s34
         2rhFPSRi8PYL7V0K0fWugIKHpr8W3sdVHvjlD2tMNPsjtOVCqqI+aUPqpGZyEzwJ7ba/
         DlTltXL3401RrmWKIVEbrBy5zrehAt/alIteswt2vs2uLOLfXWk5IearqDpneuvCx6jU
         5hdrXWjSut8K/TQ4PIOSjClEIWDFbiMsn8Ni+hd8y3I3UkPOY44h1i9ZirU9SDk5M1n1
         CIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=+RqTSQ+NT74k/oC1T8Nb5e8kb0y4gxE44JjVwpeMXDc=;
        b=Wr8fTjYYOSl+onusl4TvKSFJ+C3lyeACApE1o0TpgVXU3gVOUeiesGqDVzI2WHit9O
         tXvhg4frtcgMLEHF8+xr+UqrTgLbZ4X63E/tAUVDZzC2CDV6kHMxynVoqmSYAO8N6bbK
         6e/Ln15h/JCHOO+dDm8kArV+hBb7NQiybjhgnHgWnTtFMlbxLRK6tz0JveDXcIlJr1F5
         gBYcG3ATkt32kVadqMYc3qknB6YlBBuZ1bS9V7GyBZ852WXYkID5JodCPl0NNTuIlmcy
         JJD+pyrZ2JbTMgvzRO0gZC3H55FEauwjcrIzz8T6cuDL9IJGs/CzYyRfzUJtfBk7Nxqg
         IlxA==
X-Gm-Message-State: ANhLgQ1oKLqn0cDohHpOufLjOeyv9jHuS6N+EH/2fpkUgZjLXLkUdWs6
        cLGV7ECTZGl7qETL/CnZbifK2+xFNgg=
X-Google-Smtp-Source: ADFU+vufVkP9L5tZqrfEnE5pdzHjcG46t5chRQ9DdzUntpl2y+KQqyRTWMe8xifqkCJRSY9O5D2Bdg==
X-Received: by 2002:a17:90a:fa93:: with SMTP id cu19mr70831pjb.166.1583160186255;
        Mon, 02 Mar 2020 06:43:06 -0800 (PST)
Received: from [192.168.4.4] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id t142sm13102474pgb.31.2020.03.02.06.43.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 06:43:05 -0800 (PST)
From:   Andrew Boyer <aboyer@pensando.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Positive or negative error return codes in rdma-core?
Message-Id: <7CF6DD61-B611-4C24-98CA-5ADCCBA75553@pensando.io>
Date:   Mon, 2 Mar 2020 09:43:03 -0500
To:     linux-rdma@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Should rdma-core providers return positive or negative errors?

The siw version of resize_cq returns -EOPNOTSUPP, but the dummy routine =
returns +EOPNOTSUPP.

Thanks,
Andrew

