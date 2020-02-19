Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3419B164D86
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSSSN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 13:18:13 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42950 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSSSM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 13:18:12 -0500
Received: by mail-pl1-f181.google.com with SMTP id e8so391187plt.9
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FY2WU0dN5XyyKyJQwzIVE3abYTQmd9JxjqzdF+Xb1tc=;
        b=XZ4T/7zOK5cF9uJgm00/upL0y/rTTeG8JfF3/NOz0hevHECtebgqbMXl2/KIFEnKSW
         Krh9WWJBUuCWUZZj6Zg0FVUYrOhjYBt3IaKrpcdB1kArugxH+41yRl7toRMMg0HsMzMW
         vhg9wKShTCeMhNEJqvUpQFCBDjY/CINR/5qqOJpsAnuSmRN3uXBKbASsB5csL6EfnHsc
         Pm+T4km6V3yXyR3cTFC9FKMPLDx8JSgz49EQXru0nY4FWjlIHBE+hsayRWey5qwW5I/4
         BnYEP8hd6HqigUF+C5E0kBooRYA2XeSuzIF/t/vD1IGOqwHRe6s13sIGxFm9a9D1Arqu
         UGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FY2WU0dN5XyyKyJQwzIVE3abYTQmd9JxjqzdF+Xb1tc=;
        b=XKkYFGpMDw/VhRnerr+DDlXAptHHFDNlPsKvNDdqGgevW+bET6FsNjfFRbxLhNO1vy
         1Nm2PzvHlj0MD899GH6tlDkhD9Wn8GrkVTNDtrAZTzgO5XZpG9csM79gLV1ZodtjFkwg
         ms9DbF6KP1R2AZopJCHr75Z0VdPqiGsifxZqjvKRR+zUZQRH0NFThcWvB7Teiru1xSdB
         J1sGOkhkiomhYnCKwDHxdgGmOdmGg92B3kKezBYoUMCq+xe28EzzpxSBQRkQ8raTDJ8o
         fiGCM0FWcV/x6qHK+L6KU5bCpQARzVcB9XpUJvBrQgDTS8fmguRvGCwaMeAtBaDkJ+r7
         Y9Sg==
X-Gm-Message-State: APjAAAVlJM5GQxXF0O1jMEDQ35LZJz0kVlCgd0O3MbG63fiNwmV8AATg
        TNRjGWbuyT7KXZwwyY7XwPk6IsPDWHGabtaiMyE9MOjJMxA=
X-Google-Smtp-Source: APXvYqxMDCMQQKv9Yl72+Si2zkY6w9SViS5zt5q9WfapuMCIyd7xyF6Tu8vz3CGWYr66G85eV3lwTUUXdVUb9kAS6qs=
X-Received: by 2002:a17:902:7589:: with SMTP id j9mr27032811pll.312.1582136291857;
 Wed, 19 Feb 2020 10:18:11 -0800 (PST)
MIME-Version: 1.0
From:   Umang Patel <umangsp.1199@gmail.com>
Date:   Wed, 19 Feb 2020 23:48:01 +0530
Message-ID: <CANS8p=_m7r93sOdKrdLpaog3dQ7KJ+qjsZdEf9R6KZhDzoZy8g@mail.gmail.com>
Subject: Regarding rdma-core repo
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

I am interning right now and working on a project which uses the
rdma-core repo. Thus, I would like to ask you some of doubts regarding
the repo since i am stuck at a place. Can you please help me out with
this? I promise I will not take much of your time.

I want to know how the function "mlx5dv_wr_mr_list" works. I am able
to execute the function on the client side which completes
successfully. However, I am unable to receive any data on the server
side sent by the client. Is there some sort of special receive
function I have to use or some other methodology to receive data on
the server side. Maybe if you can give me an example code of sending
data using that function or some sort of expected flow or a pseudo
code then I would really appreciate it.

Thank you for your time.

Regards,
Umang Patel
